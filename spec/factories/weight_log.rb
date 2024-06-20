# frozen_string_literal: true

FactoryBot.define do
  factory :weight_log do
    weight { 80.0 }
    created_at { Time.zone.now }
  end
end