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

require 'rails_helper'

RSpec.describe Permission, type: :model do

	it { should belong_to(:group) }
	it { should belong_to(:control) }
	it { should belong_to(:action) }

end
