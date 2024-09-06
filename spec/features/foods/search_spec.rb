require 'rails_helper'

RSpec.describe 'Food Search', type: :feature do
  before do
    visit root_path
  end

  it 'allows the user to search for foods by ingredient and displays results' do
    # Fill in the search form with "sweet potatoes" and click "Search"
    fill_in 'ingredient', with: 'sweet potatoes'
    click_button 'Search'

    # Expect the user to be on the "/foods" page
    expect(current_path).to eq(foods_path)

    # Expect to see the total number of items returned by the search
    expect(page).to have_content("Total Results: 30000")

    # Expect to see a list of 10 foods with GTIN/UPC, description, brand owner, and ingredients
    within '#food-results' do
      expect(page).to have_css('.food', count: 10)

      within first('.food') do
        expect(page).to have_content('GTIN/UPC:')
        expect(page).to have_content('Description:')
        expect(page).to have_content('Brand Owner:')
        expect(page).to have_content('Ingredients:')
      end
    end
  end
end
