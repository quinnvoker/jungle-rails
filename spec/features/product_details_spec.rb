require 'rails_helper'

RSpec.feature "Visitor clicks on product from home page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They are sent to product page" do
    visit root_path

    first('article.product').find('h4').click

    expect(page).to have_css 'article.product-detail'
  end
end
