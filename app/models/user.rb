class User < ActiveRecord::Base
  require 'json'
  has_ancestry
  belongs_to :role
  belongs_to :parent, class_name: 'User'
  has_many :children, class_name: 'User'
  has_many :payments, dependent: :destroy
  has_many :partner_links, dependent: :destroy
  has_many :user_landings, dependent: :destroy
  has_many :landings, through: :user_landings
  has_one :wallet, dependent: :destroy

  before_create :set_default_role
  TEMP_EMAIL_PREFIX = 'change@me'
  @TEMP_EMAIL_REGEX = /\Achange@me/
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
    (is_online?) ? 'Online' : (last_sign_in_at.nil?) ? 'never' : last_sign_in_at.strftime("%d/%m/%y, %H:%M")
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
    if search
      where('name LIKE ?', "%#{search}%")
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
    pars = (session[:parent_id]) ? params.merge({parent: User.find(session[:parent_id])}) : params
    logger.debug "session: " + session.to_json.to_s
    logger.debug "pars: " + pars.to_json.to_s
    new(pars)
  end
  def search_descendants(search)
    search_res = []
    self.descendants.each do |user|
      search_res.push(user) unless (/.*#{search}.*/i =~ user.name).nil?
    end
    return search_res
  end
  private
  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
