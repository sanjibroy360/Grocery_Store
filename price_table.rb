class PriceTable
  attr_reader :price_list

  def initialize
    @price_list = {
      milk: {
        unit_price: 3.97,
        sale_price: 5.00,
        sale_quantity: 2,
      },
      bread: {
        unit_price: 2.17,
        sale_price: 3.00,
        sale_quantity: 3,
      },
      banana: {
        unit_price: 0.99,
        sale_price: 0,
        sale_quantity: 0,
      },
      apple: {
        unit_price: 0.89,
        sale_price: 0,
        sale_quantity: 20,
      },
    }
  end
end
