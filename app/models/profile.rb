class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  enum gender: { male: 0, female: 1, other: 2 }
end
