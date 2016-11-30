require_relative 'factory_customizer'

module ChairsFactory
  class Factory
    include FactoryCustomizer

    attr_reader :linked_class_name, :factory_name

    def initialize(class_name, factory_name)
      @factory_name = factory_name
      @linked_class_name = class_name
      yield if block_given?
    end

    def linked_class
      eval("#{@linked_class_name}")
    end
    def method_missing(name, *args, &block)
      if block || (args[0] && args[0][:return])
        set_method(name, args[0] || {}, &block)
      else
        if self.methods.include?(name)
          self.send(name, *args, &block)
        else
          linked_class.send(name)
        end
      end
    end
  end
end

