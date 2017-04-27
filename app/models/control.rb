# == Schema Information
#
# Table name: controls
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Control < ApplicationRecord

	#relationships
	has_many :permissions
	has_and_belongs_to_many :actions
	#validations
	validates :name, presence: true, allow_blank: false 
	after_create :save_actions

	def actions=(value)
		@actions = value
	end

	def save_actions
		@actions.each do |action_id|
			ActionsControl.create(action_id: action_id,control_id:self.id)
		end
	end
end
