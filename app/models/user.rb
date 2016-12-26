class User < ActiveRecord::Base
  require 'json'
  has_ancestry orphan_strategy: :adopt
  belongs_to :role
  before_create :set_default_role

  has_many :partner_links, dependent: :destroy

  has_many :user_landings, dependent: :destroy
  has_many :landings, through: :user_landings

  has_many :user_businesses, dependent: :destroy
  has_many :businesses, through: :user_businesses

  has_many :to_payments, class_name: 'Payment', foreign_key: 'to_user_id'
  has_many :from_payments, class_name: 'Payment', foreign_key: 'from_user_id'
  has_many :withdrawals

  has_one :wallet, dependent: :destroy
  after_create :create_wallet

  TEMP_EMAIL_PREFIX = 'change@me'
  @TEMP_EMAIL_REGEX = /\Achange@me/
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  # User Avatar Validation
  #validates_integrity_of  :avatar
  #validates_processing_of :avatar
  validates_format_of :email, :without => @TEMP_EMAIL_REGEX, on: :update
  before_update Proc.new { |user| Payment.create(to_user_id: user.id, code: 'registration_bonus', ); user.give_bonus_money(50) }, if: :deserve_bonus?
  def payments
    to_payments << from_payments
  end
  def is_online?
    !current_sign_in_at.nil?
  end
  def last_online
    (is_online?) ? 'Online' : (last_sign_in_at.nil?) ? 'Never' : last_sign_in_at.strftime("%d/%m/%y, %H:%M")
  end

  def find_for_oauth(auth, signed_in_resource = nil, session)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    logger.debug auth.to_json.to_s
    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        case auth.provider
        when 'facebook'
          user = user_from_facebook(auth)
        when 'vkontakte'
          user = user_from_vkontakte(auth)
        end
        if session[:parent_id]
          user.parent = User.find session[:parent_id]
        end
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    email && email !~ @TEMP_EMAIL_REGEX
  end

  def self.user_from_facebook(auth)
    email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
    email = auth.info.email if email_is_verified
    first, last = *(auth.info.name.split(' '))
    User.new(
      name: first,
      last_name: last,
      #username: auth.info.nickname || auth.uid,
      email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
      password: Devise.friendly_token[0,20]
    )
  end

  def self.user_from_vkontakte(auth)
    email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
    email = auth.info.email if email_is_verified
    User.new(
      name: auth.extra.raw_info.first_name,
      last_name: auth.extra.raw_info.last_name,
      birthday: auth.extra.raw_info.bdate,
      country: auth.extra.raw_info.country.title,
      city: auth.extra.raw_info.city.title,
      remote_avatar_url: auth.extra.raw_info.photo_200,
      sex: auth.extra.raw_info.sex,
      #username: auth.info.nickname || auth.uid,
      email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
      password: Devise.friendly_token[0,20]
    )
  end

  def self.new_with_session(params, session)
    # OPTIMIZE Why do we need this?
    # RESPONSE cause we dont have access to session in model
    pars = (session[:parent_id]) ? params.merge({parent: User.find(session[:parent_id])}) : params
    pars.merge!({came_from: session[:came_from]})
    logger.debug "session: " + session.to_json.to_s
    logger.debug "pars: " + pars.to_json.to_s
    new(pars)
  end

  # Search part
  def self.search search
    if search
      where('name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      all()
    end
  end

  def search_users search, collection, filters
    search_res = collection.where('name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%");
    filters = [] if filters.nil?
    filters.each do |filter|
      case filter[0]
        when 'partner'
          role_id = Role.where(name: 'partner').first.id
          search_res = search_res.where('role_id = ?',role_id)
        break
      end
    end
    # collection.each do |user|
    #   unless (/.*#{search}.*/i =~ "#{user.name} #{user.last_name}").nil? &&
    #     search_res.push(user)
    #   end
    # end
    return search_res
  end

  def search_descendants search, filters = []
    search_users(search, descendants, filters)
  end

  def search_ancestors search, filters = []
    search_users(search, ancestors, filters)
  end

  # Landings
  def landing_settings landing
    # UserLanding.find_by(user_id: id, landing_id: landing.id)
    user_landings.find_by(landing_id: landing.id)
  end

  def has_landing? landing
    # !UserLanding.find_by(user_id: id, landing_id: landing.id).nil?
    !user_landings.find_by(landing_id: landing.id).nil?
  end
  def club_links
    user_landings.select { |x| x.is_club }
  end
  #TODO remove following 2 craps from User model
  def free_land_number
    free_number = role.landing_pages_number || 0
    club_number = club_links.size
    free_number - club_number
  end
  def drop_landing landing
    landing_link = landing_settings
    landing_link.destroy
  end

  # Money part
  def enough? amount
    wallet.main_balance >= amount.to_f
  end
  def bonus_enough? amount
    wallet.bonus_balance >= amount.to_f
  end
  def give_money amount
    wallet.main_balance += amount.to_f
    wallet.save
  end
  def give_bonus_money amount
    wallet.bonus_balance += amount.to_f
    wallet.save
  end
  def take_money amount
    return unless enough? amount.to_f

    wallet.main_balance -= amount.to_f
    wallet.save
  end
  def take_bonus_money amount
    return unless bonus_enough? amount.to_f

    wallet.bonus_balance -= amount.to_f
    wallet.save
  end
  def distribute_money amount
    ancestors.reverse.each do |ancestor|
      max_depth = Role.info_select.find(ancestor.role_id).partnership_depth
      depth = calculate_depth(ancestor)
      unless depth > max_depth
        percent = PartnershipDepth.find(depth).percent / 100.0
        refback_percent = ancestor.refback_percent / 100
        if percent == 0.0
          ancestor.give_money(amount * percent)
        else
          ancestor.give_money(amount * percent * (1 - refback_percent))
          self.give_money(amount * percent * refback_percent)
        end
      end
    end
  end
  def calculate_depth ancestor
    return if !ancestor.descendant_ids.include? id
    depth - ancestor.depth
  end
  def no_reg_bonus?
    true if vk.blank?||Payment.where(to_user_id: id, code: 'registration_bonus').blank?
  end
  def deserve_bonus?
    there_was_no_data = (phone_was.blank?||vk_was.blank?||skype_was.blank?)
    there_is_new_data = !(phone.blank?&&vk.blank?&&skype.blank?)
    there_was_no_bonus = Payment.where(to_user_id: id, code: 'registration_bonus').blank?
    true if there_was_no_data && there_is_new_data && there_was_no_bonus
  end
  # Select part
  @contacts = [:phone, :skype, :vk, :fb, :ok, :youtube]
  @main_data = [:id, :role_id, :parent_id, :ancestry, :email, :name, :last_name, :avatar]
  @info = [:birthday, :sex, :country, :city, :about]

  def basic_select
    fields = @main_data + @info
    select(*fields)
  end

  # Roles part
  def set_role role
    # Available names are "user", "partner", "leader", "vip"
    @role = Role.find_by_name(role.name)
    return if @role.nil?
    self.role = @role
    self.activated_at = Time.now
    self.reactivate_at = Time.now + 30.days
    save
  end

  # JUST For Active Job, to be called when no money left
  def expiring?
    (Time.now + 2.days) > self.reactivate_at
  end
  def expired?
    Time.now > self.reactivate_at
  end
  def drop_role
    default = Role.find_by(name: 'user')
    return unless default

    user_landings.each do |landing_link|
      #if landing_link.is_club ### TODO: ask owner what to do in such case
        landing_link.destroy
      #end
    end

    user_businesses.each do |business_link|
      business_link.destroy
    end

    self.role = default
    self.save
  end

  def full_name
    # JUST Even simpler way to avoid nil to string convertation error
    "#{name} #{last_name}"
  end
  # Business part
  def business_settings business
    # UserBusiness.includes(:partner_link).find_by(user_id: self.id, business_id: business.id)
    user_businesses.includes(:partner_link).find_by(business_id: business.id)
  end

  def find_active_parent business
    ancestors.includes(:user_businesses).reverse.each do |ancestor|
      return ancestor unless ancestor.business_settings(business).nil?
    end
    nil
  end
  private
  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
