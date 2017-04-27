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

class Action < ApplicationRecord
  #plugins 
 
  #relationships 
  has_many :permissions
  has_and_belongs_to_many :controls
  
  #rules validations 
  validates :name, presence: true, allow_blank: false 
end
