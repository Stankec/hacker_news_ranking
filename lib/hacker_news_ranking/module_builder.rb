class HackerNewsRanking
  class ModuleBuilder
    attr_reader :klass
    attr_reader :options

    def initialize(klass, options = {})
      @klass = klass
      @options = options
    end

    def call
      Builder.new(adapter, options).call
    end

    private

    def adapter
      # TODO: implement logict that racefuuly checks model class without
      # requiring active record or sequel
    end
  end
end
