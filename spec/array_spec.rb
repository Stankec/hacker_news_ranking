require 'spec_helper'

describe HackerNewsRanking::ArrayMethods do
  let(:array) do
    array = (1..4).to_a
    array.singleton_class.include(HackerNewsRanking::ArrayMethods)
    array
  end

  it 'defines #rank' do
    expect(array.methods).to include(:rank)
  end

  it 'defines #rank!' do
    expect(array.methods).to include(:rank!)
  end

  it 'uses the global configuration if no arguments passed' do
    ranker = HackerNewsRanking::ArrayMethods::Ranker.new(array, points: :itself)

    expect(ranker.timestamp).to(
      eq(HackerNewsRanking::Configuration.configuration[:timestamp].to_proc)
    )
    expect(ranker.gravity).to(
      eq(HackerNewsRanking::Configuration.configuration[:gravity].to_f)
    )
  end

  describe '#rank' do
    let(:sorted_array) do
      array.rank(
        points: proc { 100 },
        timestamp: -> (number) { 5 - number },
        gravity: 5
      )
    end

    it 'sorts the array' do
      expect(sorted_array).to eq([4, 3, 2, 1])
    end

    it 'returns a different array from the one passed to it' do
      expect(sorted_array).not_to be(array)
    end
  end

  describe '#rank!' do
    let(:sorted_array) do
      array.rank!(
        points: proc { 100 },
        timestamp: -> (number) { 5 - number },
        gravity: 5
      )
    end

    it 'sorts the array' do
      expect(sorted_array).to eq([4, 3, 2, 1])
    end

    it 'returns the same array as the one passed to it' do
      expect(sorted_array).to be(array)
    end
  end
end
