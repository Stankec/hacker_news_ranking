require 'hacker_news_ranking/array_methods/ranker'

class HackerNewsRanking
  module ArrayMethods
    def rank(points: nil, timestamp: nil, gravity: 1.8)
      Ranker
        .new(self, points: points, timestamp: timestamp, gravity: gravity)
        .call
    end

    def rank!(points: nil, timestamp: nil, gravity: 1.8)
      Ranker
        .new(
          self, points: points, timestamp: timestamp, gravity: gravity,
          inplace: true
        )
        .call
    end
  end
end
