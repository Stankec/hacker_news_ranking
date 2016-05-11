require 'hacker_news_ranking/version'
require 'hacker_news_ranking/configuration'

class HackerNewsRanking
  def self.configure(&block)
    Configuration.new(&block)
    nil
  end

  def self.rank(array:, points:, timestamp:)
  end

  def self.rank!(array:, points:, timstamp:)
  end

  def initialize(options = {})
  end
end
