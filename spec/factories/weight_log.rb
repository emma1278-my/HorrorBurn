# frozen_string_literal: true

FactoryBot.define do
  factory :weight_log do
    weight { 40.5 }
    created_at { Time.zone.now }
  end
end