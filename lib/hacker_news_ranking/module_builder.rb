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
      if sequel?
        Adapter::Sequel
      elsif active_record?
        Adapter::ActiveRecord
      end
    end

    def active_record?
      return false unless active_record_defined?
      klass.is_a?(ActiveRecord::Base)
    end

    def sequel?
      return false unless sequel_defined?
      klass.is_a?(Sequel::Model)
    end

    def sequel_defined?
      !class_from_string('Sequel::Model').nil?
    end

    def active_record_defined?
      !class_from_string('ActiveRecord::Base').nil?
    end

    def class_from_string(class_name)
      Object.const_get(class_name)
    rescue NameError
      nil
    end
  end
end
