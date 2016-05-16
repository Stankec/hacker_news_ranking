class HackerNewsRanking
  class ModuleBuilder
    class Builder
      attr_reader :adapter
      attr_reader :options

      def initialize(adapter_class, options = {})
        @options = options
        @adapter = adapter_class.new(options)
      end

      def call
        adapter.call
      end
    end
  end
end
