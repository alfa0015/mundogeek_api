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

require 'rails_helper'

RSpec.describe Product, type: :model do

  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:pricing)}
  it{should validate_presence_of(:description)}
  it{should validate_presence_of(:status)}
  it{should validate_presence_of(:expired)}
  it{should validate_presence_of(:stock)}

  it { should validate_numericality_of(:pricing) }
  it { should_not allow_value(-1).for(:pricing) }
  it { should allow_value(1).for(:pricing) }

  it { should validate_numericality_of(:stock) }
  it { should_not allow_value(-1).for(:stock) }
  it { should allow_value(0).for(:stock) }

  it { should have_many(:attachments) }

  it "Deberia tener status open al crear un producto" do
    producto = FactoryGirl.create(:product)
    expect(Product.last.status).to eq("open")
  end

  it "Deberia de pasar a closed un producto en estado open" do
    FactoryGirl.create(:product)
    Product.last.close!
    expect(Product.last.status).to eq("closed")
  end

  it "Deberia de pasar a open un producto en estado closed" do
    FactoryGirl.create(:product)
    Product.last.close!
    Product.last.open!
    expect(Product.last.status).to eq("open")
  end

  it "Deberia de pasar a open un producto en estado closed" do
    FactoryGirl.create(:product)
    Product.last.exhausted!
    expect(Product.last.status).to eq("exhausted")
  end

  it "Deberia de retornar false si el stock es 0" do
    producto = FactoryGirl.create(:product,stock:"0")
    producto.exhausted!
    stock = Product.stock_product(producto,1)
    expect(stock).to be_falsy
  end

  it "Deberia de retornar false si la compra supera la existencia" do
    producto = FactoryGirl.create(:product,stock:"10")
    stock = Product.stock_product(producto,11)
    expect(stock).to be_falsy
  end

  it "Deberia de retornar true si la compra es igual a la existencia" do
    producto = FactoryGirl.create(:product,stock:"10")
    stock = Product.stock_product(producto,10)
    expect(stock).to be_truthy
  end

  it "Deberia de retornar true si la compra es menor a la existencia" do
    producto = FactoryGirl.create(:product,stock:"10")
    stock = Product.stock_product(producto,9)
    expect(stock).to be_truthy
  end

  it "Deberia de restar la existencia del producto si la compra es menor o igual a la stock" do
    producto = FactoryGirl.create(:product,stock:"10")
    stock = Product.stock_product(producto,9)
    resta = producto.stock - 9
    producto = Product.find(producto.id)
    expect(producto.stock).to eq(resta)
  end

  it "Deberia de cambiar el estado a exhausted si la compra es igual a la existencia" do
    producto = FactoryGirl.create(:product,stock:"10")
    stock = Product.stock_product(producto,10)
    producto = Product.find(producto.id)
    expect(producto.status).to eq("exhausted")
  end

end
