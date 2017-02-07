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
	#relatioships

	#Validations Rules
	validates :name,:pricing,:description,:status,:expired,:stock, presence: true, allow_blank: false
	validates :pricing,:stock,numericality:{greater_than:0}

end
