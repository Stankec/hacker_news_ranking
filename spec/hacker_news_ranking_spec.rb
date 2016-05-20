require 'spec_helper'

describe HackerNewsRanking do
  it 'has a version number' do
    expect(HackerNewsRanking::VERSION).not_to be nil
  end

  context 'class method' do
    describe '#configure' do
      let(:configuration) { HackerNewsRanking::Configuration.configuration }

      it 'returns defaults' do
        expect(configuration).to(
          include(
            timestamp: :created_at,
            gravity: 1.8,
            points_offset: -1,
            timestamp_offset: 2,
            scope_method: :trending,
            current_rank_method: :rank
          )
        )
      end

      it 'saves the passed configuration' do
        HackerNewsRanking.configure do
          points :comments_count
          timestamp :commented_at
          gravity 2.3
          points_offset 0
          timestamp_offset 3
          scope_method :controversial
          current_rank_method :points
        end

        expect(configuration).to(
          include(
            points: :comments_count,
            timestamp: :commented_at,
            gravity: 2.3,
            points_offset: 0,
            timestamp_offset: 3,
            scope_method: :controversial,
            current_rank_method: :points
          )
        )
      end
    end

    context 'ranking methods' do
      let(:array) { (1..4).to_a }

      describe '#rank' do
        let(:sorted_array) do
          HackerNewsRanking.rank(
            array: array,
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
          HackerNewsRanking.rank!(
            array: array,
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
  end

  context 'instance method' do
  end
end
