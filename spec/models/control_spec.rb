# == Schema Information
#
# Table name: controls
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Control, type: :model do
	it{should have_many(:permissions)}
	it { should have_and_belong_to_many(:actions) }
	it{should validate_presence_of(:name)}
end
