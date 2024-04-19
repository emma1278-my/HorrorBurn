class Movie < ApplicationRecord
  has_many :movies_histories
  has_many :users, through: :movies_histories
end
