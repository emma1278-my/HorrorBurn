# config/initializers/devise.rb

Devise.setup do |config|
  # Configure your Devise authentication modules here. For example:
  # config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  # ==> Configuring the authenticity token
  # CSRF protection is turned on by default. You can turn it off by commenting out the following line:
  # config.csrf = true

  # ==> Configuration for :confirmable
  # config.allow_unconfirmed_access_for = 2.days

  # ==> Configuration for :database_authenticatable
  # config.stretches = Rails.env.test? ? 1 : 11

  # ==> Configuration for :lockable
  # config.lock_strategy = :failed_attempts

  # ==> Configuration for :omniauthable
  # config.omniauth :github, 'APP_ID', 'APP_SECRET'

  # ==> Configuration for :recoverable
  # config.reset_password_keys = [:email]

  # ==> Configuration for :rememberable
  # config.remember_for = 2.weeks

  # ==> Configuration for :timeoutable
  # config.timeout_in = 30.minutes

  # ==> Configuration for :trackable
  # config.maximum_attempts = 5

  # ==> Configuration for :validatable
  # config.password_length = 6..128

  # ==> Configuration for :confirm_within
  # config.confirm_within = 3.days

  # ==> Configuration for :password_length
  # config.password_length = 8..128

  # ==> Configuration for :email_regexp
  # config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :lock_strategy
  # config.lock_strategy = :failed_attempts

  # ==> Configuration for :unlock_keys
  # config.unlock_keys = [:email]

  # ==> Configuration for :jwt
  # config.jwt_expiration_time = 3600

  # ==> Configuration for :jwt_revocation_strategy
  # config.jwt_revocation_strategy = JwtBlacklist
end
