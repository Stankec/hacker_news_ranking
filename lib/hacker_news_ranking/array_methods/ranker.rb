class HackerNewsRanking
  module ArrayMethods
    class Ranker
      attr_reader :array
      attr_reader :points
      attr_reader :timestamp
      attr_reader :gravity
      attr_reader :inplace

      def initialize(
        array, points: nil, timestamp: nil, gravity: nil, inplace: false
      )
        @array = array
        @points = points || configuration[:points]
        @timestamp = timestamp || configuration[:timestamp]
        @gravity = gravity || configuration[:gravity]
        @inplace = inplace
      end

      def call
        return rank! if inplace
        rank
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

      private

      attr_reader :formula

      def configuration
        HackerNewsRanking::Configuration.configuration
      end

      def rank
        array.sort_by(&formula).reverse!
      end

      def rank!
        array.sort_by!(&formula).reverse!
      end

      def formula
        @formula ||= proc do |element|
          points.call(element) / timestamp.call(element)**gravity
        end
      end
    end
  end
end
