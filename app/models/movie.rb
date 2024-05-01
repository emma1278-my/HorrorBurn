class Movie < ApplicationRecord
  has_many :movie_histories
  has_many :users, through: :movie_histories
end
