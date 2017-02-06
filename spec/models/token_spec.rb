# == Schema Information
#
# Table name: tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  expires_at :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Token, type: :model do
	it { should belong_to(:user) }
	it{should validate_presence_of(:token)}

	it "Deberia de retornar un token" do
		token = Token.generate_token
		expect(token.token).not_to be_empty
	end

  
	it "Deberia retornar valido cuando si no a expirado" do
		token = FactoryGirl.create(:token,expires_at: DateTime.now + 1.minute)
		expect(token.is_valid?).to eq(true)
	end

  	it "Deberia retornar invalido cuando si esta a expirado" do
  		token = FactoryGirl.create(:token,expires_at: DateTime.now - 1.minute)
  		expect(token.is_valid?).to eq(false)
  	end

end
