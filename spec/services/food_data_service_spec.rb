require 'rails_helper'

RSpec.describe FoodDataService do
  it 'retrieves food data from the API' do
    response = File.read(Rails.root.join('spec', 'fixtures', 'sweet_potatoes_search_response.json'))

    stub_request(:get, "https://api.nal.usda.gov/fdc/v1/foods/search")
      .with(query: hash_including({ "query" => "sweet potatoes", "api_key" => Rails.application.credentials.usda[:api_key] }))
      .to_return(body: response, headers: { 'Content-Type' => 'application/json' })

    result = FoodDataService.search('sweet potatoes')

    expect(result).to have_key(:totalHits)
    expect(result[:foods].first).to have_key(:gtinUpc)
  end
end
