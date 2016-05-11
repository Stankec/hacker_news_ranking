class HackerNewsRanking
  class Configuration
    @@configuration = {
      timestamp: :created_at,
      gravity: 1.8,
      scope_method: :trending,
      current_rank_method: :rank
    }

    def self.configuration
      @@configuration ||= {}
    end

    def initialize(&block)
      instance_eval(&block)
    end

    private

    def configuration
      self.class.configuration
    end

    def points(points)
      configuration[:points] = points
    end

    def timestamp(timestamp)
      configuration[:timestamp] = timestamp
    end

    def gravity(gravity)
      configuration[:gravity] = gravity
    end

    def scope_method(scope_method)
      configuration[:scope_method] = scope_method
    end

    def current_rank_method(current_rank_method)
      configuration[:current_rank_method] = current_rank_method
    end
  end
end
