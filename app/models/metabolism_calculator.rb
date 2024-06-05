# frozen_string_literal: true

class MetabolismCalculator < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :weight
end
