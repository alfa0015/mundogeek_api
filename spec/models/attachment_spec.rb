# == Schema Information
#
# Table name: attachments
#
#  id                 :integer          not null, primary key
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do

	it { should belong_to(:product) }
	it { should have_attached_file(:image) }
	it { should validate_attachment_presence(:image) }
	it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/jpg?g', 'image/gif').
                rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:image).
                less_than(10.megabytes) }
end
