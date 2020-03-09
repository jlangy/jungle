require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject {
      Product.new(
        name:"Toothpaste", 
        price_cents:100, 
        quantity:100, 
        category: Category.new
      )}
    it 'is valid with valid attributes' do 
      expect(subject).to be_valid;
    end

    it 'is not valid without a valid name' do
      subject.name = nil;
      expect(subject).to be_invalid;
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a valid price' do
      subject.price_cents = nil;
      expect(subject).to be_invalid;
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a valid quantity' do
      subject.quantity = nil;
      expect(subject).to be_invalid;
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a valid category' do
      subject.category = nil;
      expect(subject).to be_invalid;
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end
  end
end
