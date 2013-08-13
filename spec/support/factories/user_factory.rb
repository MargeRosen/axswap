FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@AxSwap.com"}
    password "password"
    password_confirmation "password"

    factory :confirmed_user do
      after_create do |user|
        user.confirm!
      end
    end

  # Create Admin - only way to CRUD Categories
    factory :admin_user do
      after_create do |user|
        user.confirm!
        user.update_attribute(:admin, true)
      end
    end
  end
end
