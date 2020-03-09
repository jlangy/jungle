require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        image: open_asset('apparel1.jpg'),
        price: 64.99
      )
    end
  end

  scenario "they navigate to product" do 
    visit root_path

    save_screenshot

    find('.product header', match: :first).click
    #Should redirect to one of 10 products
    expect(page).to have_current_path(/products\/[0-10]+/)
  end

end
