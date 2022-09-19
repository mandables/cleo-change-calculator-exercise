require 'change_calculator'
require 'coin'

RSpec.describe ChangeCalculator do
  it 'exists' do
    expect(defined? described_class).to be_truthy
  end

  describe '.calculate' do
    context 'with unlimited change' do
      let(:two_pound_coin) { Change.new(value_in_pence: 200, current_quantity: 1, max_quantity: 100) }
      let(:one_pound_coin) { Change.new(value_in_pence: 100, current_quantity: 1, max_quantity: 100) }
      let(:two_pence) { Change.new(value_in_pence: 1, current_quantity: 1, max_quantity: 100) }
      let(:change) { 212 }
      let(:expected_change) do
        {
          200 => 1,
          10 => 1,
          2 => 1
        }
      end

      it 'returns the correct change' do
        expect(ChangeCalculator.new(change).calculate).to eq(expected_change)
      end
    end
  end

  describe '.calculate_with_limited_coins' do
    context 'with limited change' do
      let!(:two_pounds) { Coin.new(value_in_pence: 200, current_quantity: 1, max_quantity: 100) }
      let!(:ten_pence) { Coin.new(value_in_pence: 10, current_quantity: 1, max_quantity: 100) }
      let!(:one_pence) { Coin.new(value_in_pence: 1, current_quantity: 2, max_quantity: 100) }
      let(:change) { 212 }
      let(:expected_change) do
        {
          200 => 1,
          10 => 1,
          1 => 2
        }
      end

      it 'returns the correct change' do
        expect(ChangeCalculator.new(change).calculate_with_limited_coins).to eq(expected_change)
      end
    end
  end

end
