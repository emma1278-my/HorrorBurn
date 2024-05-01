class MovieHistory < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :movie
end
