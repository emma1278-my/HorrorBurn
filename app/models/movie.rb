class Movie < ApplicationRecord
  has_many :movie_histories, dependent: :destroy
  has_many :users, through: :movie_histories
end
