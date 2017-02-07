# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  pricing     :decimal(, )
#  description :string
#  status      :string
#  expired     :date
#  stock       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :product do
    name "MyString"
    pricing "9.99"
    description "MyString"
    status "MyString"
    expired "2017-02-07"
    stock 1
  end
end
