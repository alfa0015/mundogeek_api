# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  name       :string
#  control_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  permit     :boolean
#

FactoryGirl.define do
  factory :action do
    name "MyString"
    permit true
    association :control, factory: :control
  end
end
