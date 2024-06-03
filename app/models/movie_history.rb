class MovieHistory < ApplicationRecord
  belongs_to :user

  validates :movie_id, presence: true
end
