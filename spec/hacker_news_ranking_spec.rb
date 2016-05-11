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
          scope_method :controversial
          current_rank_method :points
        end

        expect(configuration).to(
          include(
            points: :comments_count,
            timestamp: :commented_at,
            gravity: 2.3,
            scope_method: :controversial,
            current_rank_method: :points
          )
        )
      end
    end
  end

  context 'instance method' do
  end
end
