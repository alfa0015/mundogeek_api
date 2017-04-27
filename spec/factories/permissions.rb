# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  group_id    :integer
#  control_id  :integer
#  action_id   :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :permission do
    group nil
    control nil
    action nil
    description "MyText"
  end
end
