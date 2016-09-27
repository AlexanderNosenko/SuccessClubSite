class User < ActiveRecord::Base
  require 'json'
  has_ancestry
  belongs_to :role
  before_create :set_default_role

  # OPTIMIZE We never used this tables, really 
  belongs_to :parent, class_name: 'User'
  has_many :children, class_name: 'User'
  has_many :partner_links, dependent: :destroy
  
  has_many :user_landings, dependent: :destroy
  has_many :landings, through: :user_landings

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

  def is_online?
    !current_sign_in_at.nil?
  end
  def last_online
    (is_online?) ? 'Online' : (last_sign_in_at.nil?) ? 'Never' : last_sign_in_at.strftime("%d/%m/%y, %H:%M")
  end

  def self.find_for_oauth(auth, signed_in_resource = nil, session)
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
    self.email && self.email !~ @TEMP_EMAIL_REGEX
  end
  def self.search(search)
    # OPTIMIZE Are we using this?
    if search
      where('name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      all()
    end
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
    pars = (session[:parent_id]) ? params.merge({parent: User.find(session[:parent_id])}) : params
    logger.debug "session: " + session.to_json.to_s
    logger.debug "pars: " + pars.to_json.to_s
    new(pars)
  end

  # Search part
  def self.search(search)
    if search
      where('name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      all()
    end
  end

  def search_users(search, collection)
    search_res = []
    collection.each do |user|
      unless (/.*#{search}.*/i =~ "#{user.name} #{user.last_name}").nil?
        search_res.push(user)
      end
    end
    return search_res
  end

  def search_descendants(search)
    return search_users(search, self.descendants)
  end

  def search_ancestors(search)
    return search_users(search, self.ancestors)
  end

  # Landings
  def has_landing? landing
    UserLanding.find_by(user_id: id, landing_id: landing.id).nil?
  end
  def free_land_number
    links = self.user_landings
    free_number = self.role.landing_pages_number
    links.each do |link|
      lapse = link.reactivate_at - link.activated_at
      if lapse > 30.days
        free_number -= 1
      end
    end
    return free_number
  end

  # Money part
  def enough?(amount)
    return self.wallet.main_balance >= amount
  end
  def give_money(amount)
    self.wallet.main_balance += amount.to_f
    return self.wallet.save
  end
  def give_bonus_money(amount)
    self.wallet.bonus_balance += amount.to_f
    return self.wallet.save
  end
  def take_money(amount)
    if self.wallet.main_balance < amount.to_f
      return
    end
    self.wallet.main_balance -= amount.to_f
    return self.wallet.save
  end
  def take_bonus_money(amount)
    if self.wallet.bonus_balance < amount.to_f
      return
    end
    self.wallet.bonus_balance -= amount.to_f
    return self.wallet.save
  end

  # Select part
  @contacts = [:phone, :skype, :vk, :fb, :ok, :youtube]
  @main_data = [:id, :role_id, :parent_id, :ancestry, :email, :name, :last_name, :avatar]
  @info = [:birthday, :sex, :country, :city, :about]

  def self.basic_select()
    fields = @main_data + @info
    select(*fields)
  end

  # Roles part
  # JUST This will be a mark for recently implemented features
  def set_role(role)
    # Available names are "user", "partner", "leader", "vip" 
    role = Role.find_by_name(role.name)
    if role.nil?
      return nil
    else
      self.role = role
      return self.save
    end
  end
  def full_name
    self.name + " " + self.last_name
  end
  private
  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
