FactoryBot.define do
  factory :user do
    name { 'Taro' }
    email { 'example@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
