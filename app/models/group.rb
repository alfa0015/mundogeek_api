class Group < ApplicationRecord

	#plugins

	#relationships
	has_many :users
	
	#rules validation
	validates :name, presence: true, allow_blank: false

end
