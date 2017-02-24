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

FactoryGirl.define do

	factory :attachment do
		image Rack::Test::UploadedFile.new("#{Rails.root}/spec/images/s-l1600-1.jpg", "image/jpg")
	end

end
