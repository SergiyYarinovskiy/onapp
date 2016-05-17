FactoryGirl.define do
  factory :admin_user do
    email FFaker::Internet.email
    password 'password'
  end

  factory :new_admin_user, class: AdminUser do
    email FFaker::Internet.email
    password 'PassworD'
  end
end
