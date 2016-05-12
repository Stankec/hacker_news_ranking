class HackerNewsRanking
  module ArrayMethods
    class Ranker
      attr_reader :array
      attr_reader :points
      attr_reader :timestamp
      attr_reader :gravity

      def initialize(array, points: nil, timestamp: nil, gravity: nil)
        @array = array
        @points = points || configuration[:points]
        @timestamp = timestamp || configuration[:timestamp]
        @gravity = gravity || configuration[:gravity]
      end

      def rank
        array.sort_by(&formula)
      end

      def rank!
        array.sort_by!(&formula)
      end

      private

      attr_reader :formula

      def configuration
        HackerNewsRanking::Configuration.configuration
      end

      def formula
        @formula ||= proc do |element|
          (points.call(element) - 1) / (timestamp.call(element) + 2)**gravity
        end
      end

      def points
        @points.to_proc
      end

      def timestamp
        @timestamp.to_proc
      end

      def gravity
        @gravity.to_f
      end
    end
  end
end
