class MovieHistory < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :movie_id, presence: true

end
