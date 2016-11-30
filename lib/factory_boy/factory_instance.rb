require_relative '../factory_boy'

module FactoryBoy
  class FactoryInstance
    attr_reader :factory_name, :object_inputs, :linked_object

    def initialize(factory_name, object_inputs)
      @factory_name = factory_name
      @object_inputs = object_inputs

      @object_inputs.each { |method_name, val| 
        define_singleton_method(method_name) do 
          val
        end
      }
    end

    def activate_object
      klass = FactoryBoy.factories[@factory_name].linked_class
      @linked_object = klass.new(*@object_inputs.values)
    end

    def method_missing(name, *args, &block)
      if @linked_object.methods.include?(name)
        @linked_object.send(name, *args, &block)
      else
        super
      end
    end
  end
end
