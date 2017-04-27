# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  group_id               :integer          default("2")
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it{should validate_presence_of(:email)}
  it{should validate_uniqueness_of(:email).case_insensitive}
  it{should validate_presence_of(:password)}

  it { should have_many(:tokens) }
  it { should belong_to(:group) }
end
