class HackerNewsRanking
  class Configuration
    @@configuration = {
      timestamp: :created_at,
      gravity: 1.8,
      points_offset: -1,
      timestamp_offset: 2,
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

    def points_offset(points_offset)
      configuration[:points_offset] = points_offset
    end

    def timestamp_offset(timestamp_offset)
      configuration[:timestamp_offset] = timestamp_offset
    end

    def scope_method(scope_method)
      configuration[:scope_method] = scope_method
    end

    def current_rank_method(current_rank_method)
      configuration[:current_rank_method] = current_rank_method
    end
  end
end
