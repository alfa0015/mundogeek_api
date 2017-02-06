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

class Token < ApplicationRecord
	#relationship
	belongs_to :user

	#Validations Rules
	validates :token, presence: true, allow_blank: false

	def is_valid?
		DateTime.now < self.expires_at
	end

	private
  	def self.generate_token
  		begin
  			token = SecureRandom.hex
  		end while Token.where(token: token).any?
  		expires_at ||= 1.year.from_now
      	Token.create(:expires_at=>expires_at,:token=>token)
  	end

end
