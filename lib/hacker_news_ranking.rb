require 'hacker_news_ranking/version'
require 'hacker_news_ranking/configuration'
require 'hacker_news_ranking/array_methods'

class HackerNewsRanking < Module
  def self.configure(&block)
    Configuration.new(&block)
    nil
  end

  def self.rank(array:, points: nil, timestamp: nil, gravity: nil)
    ArrayMethods::Ranker
      .new(array, points: points, timestamp: timestamp, gravity: gravity)
      .call
  end

  def self.rank!(array:, points: nil, timestamp: nil, gravity: nil)
    ArrayMethods::Ranker
      .new(
        array, points: points, timestamp: timestamp, gravity: gravity,
        inplace: true
      )
      .call
  end

  def initialize(options = {})
  end
end
