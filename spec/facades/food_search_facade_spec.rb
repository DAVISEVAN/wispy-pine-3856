require 'rails_helper'

RSpec.describe FoodSearchFacade do
  it 'returns an array of Food objects' do
    response = File.read(Rails.root.join('spec', 'fixtures', 'sweet_potatoes_search_response.json'))

    stub_request(:get, "https://api.nal.usda.gov/fdc/v1/foods/search")
      .with(query: hash_including({ "query" => "sweet potatoes", "api_key" => Rails.application.credentials.usda[:api_key] }))
      .to_return(body: response, headers: { 'Content-Type' => 'application/json' })

    foods = FoodSearchFacade.search('sweet potatoes')

    expect(foods).to be_an(Array)
    expect(foods.first).to be_a(Food)
    expect(foods.first.gtin_upc).to eq('046567926179')
  end

  it 'returns the total results count' do
    response = File.read(Rails.root.join('spec', 'fixtures', 'sweet_potatoes_search_response.json'))

    stub_request(:get, "https://api.nal.usda.gov/fdc/v1/foods/search")
      .with(query: hash_including({ "query" => "sweet potatoes", "api_key" => Rails.application.credentials.usda[:api_key] }))
      .to_return(body: response, headers: { 'Content-Type' => 'application/json' })

    total_results = FoodSearchFacade.total_results('sweet potatoes')

    expect(total_results).to eq(56910)
  end
end
