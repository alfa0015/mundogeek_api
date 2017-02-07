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

require 'rails_helper'

RSpec.describe Product, type: :model do
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:pricing)}
  it{should validate_presence_of(:description)}
  it{should validate_presence_of(:status)}
  it{should validate_presence_of(:expired)}
  it{should validate_presence_of(:stock)}

  it { should validate_numericality_of(:pricing) }
  it { should_not allow_value(-1).for(:pricing) }
  it { should allow_value(1).for(:pricing) }

  it { should validate_numericality_of(:stock) }
  it { should_not allow_value(-1).for(:stock) }
  it { should allow_value(1).for(:stock) }
end
