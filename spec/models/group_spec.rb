# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:users) }
  it{should validate_presence_of(:name)}
end
