class User < ActiveRecord::Base
  attr_accessible :email, :login, :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable #:token_authenticable,

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :as => :admin

  def to_s
  "#{email} (#{admin? ? "Admin" : "User"})"
  end
#Should add checks on email or username?
  #validates_presence_of :username
  #validates_uniqueness_of :username

  def self.from_omniauth(auth)
    binding.pry
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.email # "test@example.com"
      user.password = new_secure_random_password #auth.password #"password"
      user.confirm!
      if user.save
        logger.info "user was saved"
      else
        logger.info "user was not saved"
      end
      #user.username = auth.info.nickname
    end
  end

  def self.new_with_sesson(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        #binding.pry
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private

  def new_secure_random_password
    user.password = "S3cur34U"
  end
end
