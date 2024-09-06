class FoodDataService
  def self.search_foods(ingredient)
    response = Faraday.get("https://api.nal.usda.gov/fdc/v1/foods/search") do |req|
      req.params['api_key'] = Rails.application.credentials.usda[:api_key]
      req.params['query'] = ingredient
      req.params['pageSize'] = 10
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
