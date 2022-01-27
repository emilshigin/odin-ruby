def stock_picker(daily_prices)
  buy_day = 0
  buy_price = daily_prices[0]
  profit = 0
  day = [0,0]
  
  daily_prices.each_with_index do |price, index|
    if price < buy_price
      buy_day = index
      buy_price = price
      next
    end

    if price - buy_price > profit
      profit = price - buy_price
      day = [buy_day, index]
    end
  end
  day
end

p [17,3,6,9,15,8,6,1,10]
p stock_picker([17,3,6,9,15,8,6,1,10]) #=> [1,4] 