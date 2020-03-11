require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  before :each do
    User.create!(email:'a@b.com', first_name: 'Jane', last_name: 'Blue', password: '123', password_confirmation: '123')
  end

  scenario 'user logs in' do
    visit '/login'

    fill_in 'email', with: 'a@b.com'
    fill_in 'password', with: '123'
    
    click_on 'Submit'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Jane')
  end
end
