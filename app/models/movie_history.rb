class MovieHistory < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
