require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Food Search', type: :feature do
  before do
    fixture_data = File.read(Rails.root.join('spec', 'fixtures', 'sweet_potatoes_search_response.json'))
    stub_request(:get, "https://api.nal.usda.gov/fdc/v1/foods/search")
      .with(query: hash_including({ "query" => "sweet potatoes", "api_key" => Rails.application.credentials.usda[:api_key] }))
      .to_return(body: fixture_data, headers: { 'Content-Type' => 'application/json' })
  end

  it 'allows the user to search for foods by ingredient and displays results' do
    visit root_path
    fill_in 'ingredient', with: 'sweet potatoes'
    click_button 'Search'

    expect(current_path).to eq(foods_path)

    total_results_text = find('h2').text
    total_results_number = total_results_text.scan(/\d+/).first.to_i
    expect(total_results_number).to be > 30000

    within '#food-results' do
      expect(page).to have_css('.food', count: 1)

      within first('.food') do
        expect(page).to have_content('GTIN/UPC: 046567926179')
        expect(page).to have_content('Description: SWEET POTATOES')
        expect(page).to have_content('Brand Owner: Raley\'s')
        expect(page).to have_content('Ingredients: SWEET POTATOES.')
      end
    end
  end
end
