require 'rails_helper'

RSpec.feature "Visitor attempts to log in", type: :feature, js: true do
  before :each do
    User.create!(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
  end

  scenario "They should be logged in successfully" do
    visit root_path

    click_on('Log In')
    
    expect(page).to have_content 'Email'

    fill_in 'Email', with: 'john@smith.com'
    fill_in 'Password', with: 'jonny'
    click_on('Submit')

    expect(page).to have_content 'Log Out'
  end
end
