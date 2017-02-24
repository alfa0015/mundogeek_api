# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  pricing     :decimal(, )
#  description :string
#  status      :string
#  expired     :date
#  stock       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
	#callbaks
	#after_create :save_attachments
	#plugins
	include AASM

	#relatioships
	has_many :attachments,:dependent => :destroy
	
	#Validations Rules
	validates :name,:pricing,:description,:status,:expired,:stock, presence: true, allow_blank: false
	validates :pricing,numericality:{greater_than:0}
	validates :stock,numericality:{greater_than_or_equal_to:0}

	accepts_nested_attributes_for :attachments, :reject_if => lambda { |a| a[:attachment].blank? }, allow_destroy: true
	accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['attachment'].blank? }, :allow_destroy => true


	#AASM Configuration
	aasm column: "status" do
	    state :open, initial: true
	    state :closed
	    state :exhausted

	    event :close do
	        transitions from: :open, to: :closed
	    end

		event :open do
	        transitions from: :closed, to: :open
	    end

	    event :exhausted do
	        transitions from: :open, to: :exhausted
	    end
  	end

  	#Metodos del modelo
  	def self.stock_product(product,number)
		producto = Product.find(product.id)
		stock_current = producto.stock
		if product.status == "exhausted"
			return false
		else
			stock_current = stock_current - number
			if stock_current < 0
				return false
			else
				producto.update(stock:stock_current)
				if stock_current == 0
					producto.exhausted!
				end
				return true
			end
		end
	end

	private

		def save_attachments
  			@attachments.each do |image|
  				Attachment.create(image:image,product_id:self.id)
  			end
  		end

end
