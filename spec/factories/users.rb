# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  group_id               :integer          default("2")
#

FactoryGirl.define do
  factory :user do
    email "rafael@test.local"
    password "password"
    password_confirmation "password"
    association :group, factory: :group
    factory :user_sequence do
        sequence(:email){ |n| "user#{n}@test.local" }
        password "password"
        password_confirmation "password"
        association :group, factory: :group
    end
  end
end
