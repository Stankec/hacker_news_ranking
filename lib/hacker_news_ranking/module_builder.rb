class HackerNewsRanking
  class ModuleBuilder
    attr_reader :klass
    attr_reader :options
    attr_reader :mixin

    def initialize(klass, options = {})
      @klass = klass
      @options = configuration.merge(options)
      @mixin = Module.new
    end

    def call
      mixin
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
