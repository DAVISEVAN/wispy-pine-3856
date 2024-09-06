class FoodSearchFacade

  def self.search(ingredient)
      data = FoodDataService.search(ingredient)
      data[:foods].map do |food_data|
        Food.new(food_data)
     end
  end

  def self.total_results(ingredient)
    data = FoodDataService.search(ingredient)
    data[:totalHits]
  end
end