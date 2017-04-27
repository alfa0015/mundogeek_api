# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  group_id    :integer
#  control_id  :integer
#  action_id   :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Permission < ApplicationRecord
  belongs_to :group
  belongs_to :control
  belongs_to :action
end
