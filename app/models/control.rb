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
	validates :name, presence: true, allow_blank: false 
end
