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

class Attachment < ApplicationRecord
	#relatioships
	belongs_to :product

	#Validation rules
	validates :image, attachment_presence: true
	validates_with AttachmentSizeValidator, attributes: :image, less_than: 10.megabytes

	has_attached_file :image,styles: { phone: "320 x 568 >",table: " 1280 x 800 >", desktop: "1280 x 720>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/,/gif\Z/]
end
