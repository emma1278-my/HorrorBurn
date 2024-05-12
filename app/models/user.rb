class User < ApplicationRecord
  authenticates_with_sorcery!
 
  mount_uploader :avatar, AvatarUploader
  
  validates :email, uniqueness: { scope: :is_deleted }, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_one :profile, dependent: :destroy
  has_many :movie_histories
  has_many :movies, through: :movie_histories
  has_one :dashboard, class_name: 'UserDashboard'
  has_many :weight_logs, dependent: :destroy
   
  def soft_delete
    update(is_deleted: Time.current)
  end

  private

  def active_for_authentication?
    super && is_deleted.nil?
  end


    # ランダムなユーザーIDを生成
  def set_user_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
    end
  end

    # ゲストユーザーを作成する
  def self.guest_login
      random_pass = SecureRandom.base36
      create!(name: "ゲストユーザー",
              password: random_pass,
              guest: true)
  end
end
