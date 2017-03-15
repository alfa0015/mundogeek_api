# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord

	#plugins

	#relationships
	has_many :users
	
	#rules validation
	validates :name, presence: true, allow_blank: false

end
