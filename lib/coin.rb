class Coin

  attr_reader :value_in_pence, :current_quantity, :max_quantity

  @@all = []

  def initialize(value_in_pence:, current_quantity:, max_quantity:)
    @value_in_pence = value_in_pence
    @current_quantity = current_quantity
    @max_quantity = max_quantity
    @@all << self
  end

  def self.all
    # Sorted in descending value_in_pence order so the minimum 
    # amount of change is provided
    @@all.sort_by { |coin| -coin.value_in_pence }
  end

end