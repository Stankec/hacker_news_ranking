class HackerNewsRanking
  class ModuleBuilder
    module Adapter
      class Base
        attr_reader :options

        def initialize(options)
          @options = configuration.merge(options)
        end

        def call
          raise(NotImplementedError)
        end

        private

        def configuration
          HackerNewsRanking::Configuration.configuration
        end

        def points
          options[:points]
        end

        def timestamp
          options[:timestamp]
        end

        def gravity
          options[:gravity]
        end

        def scope_method
          options[:scope_method]
        end

        def current_rank_method
          options[:current_rank_method]
        end
      end
    end
  end
end
