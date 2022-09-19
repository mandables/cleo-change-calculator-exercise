class ChangeCalculator

  DENOMINATIONS = [ 200, 100, 50, 20, 10, 5, 2, 1 ]

  def initialize(change)
    @change = change
  end

  def calculate
    required_change = {}
    DENOMINATIONS.each do |denomination|
      next if (@change/denomination).zero?

      required_change[denomination] = @change/denomination
      @change = @change - (denomination * (@change/denomination))
    end
    required_change
  end

  def calculate_with_limited_coins
    required_change = {}
    Coin.all.each do |coin|
      next if (@change/coin.value_in_pence).zero? || coin.current_quantity.zero?

      if not_enough_change(coin)
        required_change[coin.value_in_pence] = @change/coin.value_in_pence
        @change = @change - (coin.value_in_pence * (@change/coin.value_in_pence))
      else 
        required_change[coin.value_in_pence] = coin.current_quantity
        @change = @change - (coin.value_in_pence * coin.current_quantity)
      end
    end
    required_change
  end

  def not_enough_change(coin)
    @change/coin.value_in_pence > coin.current_quantity
  end
end
