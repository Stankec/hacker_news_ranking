require 'hacker_news_ranking/version'
require 'hacker_news_ranking/configuration'
require 'hacker_news_ranking/array_methods'

class HackerNewsRanking
  def self.configure(&block)
    Configuration.new(&block)
    nil
  end

  def self.rank(array:, points: nil, timestamp: nil, gravity: nil)
    Array::Ranker
      .new(array, points: points, timestamp: timestamp, gravity: gravity)
      .rank
  end

  def self.rank!(array:, points: nil, timstamp: nil, gravity: nil)
    Array::Ranker
      .new(array, points: points, timestamp: timestamp, gravity: gravity)
      .rank!
  end

  def initialize(options = {})
  end
end
