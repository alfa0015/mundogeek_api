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

require 'rails_helper'

RSpec.describe Action, type: :model do
  it { should belong_to(:control) }
  it {should validate_presence_of(:name)}
end
