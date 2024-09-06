require 'rails_helper'

RSpec.describe Food do
  it 'exists and has attributes' do
    food_data = {
      gtinUpc: '046567926179',
      description: 'SWEET POTATOES',
      brandOwner: "Raley's",
      ingredients: 'SWEET POTATOES.'
    }

    food = Food.new(food_data)

    expect(food).to be_a(Food)
    expect(food.gtin_upc).to eq('046567926179')
    expect(food.description).to eq('SWEET POTATOES')
    expect(food.brand_owner).to eq("Raley's")
    expect(food.ingredients).to eq('SWEET POTATOES.')
  end
end
