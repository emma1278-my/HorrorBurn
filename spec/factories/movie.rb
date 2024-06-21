# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { 'Test Movie' }
    release_date { '2023-10-01' }
    runtime { 120 }
  end
end