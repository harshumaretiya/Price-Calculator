class PriceCalculator
  
  def initialize()
    @total_price = 0
    @invoice_amount_without_discount = 0
  end

  ITEM_UNIT_PRICES = {
    milk: 3.97,
    bread: 2.17,
    apple: 0.89,
    banana: 0.99
  }

  OFFER_PRICES = {
    milk: {
      quantity: 2,
      price: 5.00
    },

    bread: {
      quantity: 3,
      price: 6.00    	
    }
  }

  def user_input
    puts "Please enter all the items purchased separated by a comma -: \n"
    @items = gets.split(' ').join().split(',')
    convert_item_to_quantity_count_hash
  end

  def calculate_amount
    puts "Item      Quantity      Price"
    puts "--------------------------------------"
    @item_quantity_hash.each do |item, quantity|
      @item_total_price = quantity * ITEM_UNIT_PRICES[item]
      if !OFFER_PRICES[item].nil?
        remainder = quantity % OFFER_PRICES[item][:quantity]	
        divider = quantity / OFFER_PRICES[item][:quantity]
        @total_price += @item_quantity_test = divider * OFFER_PRICES[item][:price] + remainder * ITEM_UNIT_PRICES[item]
      else
      	@total_price += @item_quantity_test = @item_total_price
      end
      puts "#{'%-11s' % item.capitalize}#{'%-14s' % quantity}$#{@item_quantity_test}"  
      @invoice_amount_without_discount += @item_total_price
    end
    
    @total_price.round(2)
  end	

  def calculate_saved_amount
    (@invoice_amount_without_discount - @total_price).round(2)
  end

  private

  def convert_item_to_quantity_count_hash
    @item_quantity_hash = @items.inject(Hash.new(0)) { |total, item| total[item.to_sym] += 1 ;total}
  end

end

price_calculator = PriceCalculator.new
price_calculator.user_input
puts "Total price : $" + price_calculator.calculate_amount.to_s
puts "You saved $" + price_calculator.calculate_saved_amount.to_s + " today."
