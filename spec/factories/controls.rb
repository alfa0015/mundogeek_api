# == Schema Information
#
# Table name: controls
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :control do
    name "MyString"
    actions {[FactoryGirl.create(:action)]}
  end
end
