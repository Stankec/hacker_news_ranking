require 'spec_helper'

describe HackerNewsRanking::ArrayMethods do
  let(:array) do
    array = (1..4).to_a
    array.singleton_class.include(HackerNewsRanking::ArrayMethods)
    array
  end

  shared_examples 'it sorts the array' do sorted_array
    it 'sorts the array' do
      expect(sorted_array).to(
        eq(
          [

          ]
        )
      )
    end
  end

  it 'defines #rank' do
    expect(array.methods).to include(:rank)
  end

  it 'defines #rank!' do
    expect(array.methods).to include(:rank!)
  end

  describe '#rank' do
  end

  describe '#rank!' do
  end
end
