# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  name       :string
#  control_id :integer
#  permit     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Action, type: :model do

	it { should have_many(:permissions) } 
	it { should have_and_belong_to_many(:controls) }
	it {should validate_presence_of(:name)} 
	
end
