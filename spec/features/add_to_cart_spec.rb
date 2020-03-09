require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
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

  scenario "they add to cart" do 
    visit root_path
    expect(page).to_not have_content("My Cart (1)")

    click_on('Add', match: :first)

    expect(page).to have_content("My Cart (1)")
  end

end
