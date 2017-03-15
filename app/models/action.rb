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

class Action < ApplicationRecord
	#plugins

	#relationships
	belongs_to :control

	#rules validations
	validates :name, presence: true, allow_blank: false
end
