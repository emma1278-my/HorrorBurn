class User < ApplicationRecord
  authenticates_with_sorcery!
  
  mount_uploader :avatar, AvatarUploader
  
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
 
  def active_for_authentication?
    super && (is_deleted == false)
  end

  private
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
