# == Schema Information
#
# Table name: actions_controls
#
#  id         :integer          not null, primary key
#  action_id  :integer
#  control_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActionsControl < ApplicationRecord

end
