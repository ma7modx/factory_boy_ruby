require_relative 'factory'
require_relative 'factory_instance'

module FactoryDeclarator
  @@factories ||= {}

  def define(&block)
    self.instance_eval(&block)
  end

  def factory(factory_name, hash = {}, &block)
    class_name = hash[:class] || factory_name.to_s.capitalize
    @@factories[factory_name] = ChairsFactory::Factory.new(class_name, factory_name)
    @@factories[factory_name].instance_eval(&block) if block
  end

  def build(factory_name, options = {})
    factory = @@factories[factory_name]
    klass = factory.linked_class
    initialize_parameters = klass.instance_method(:initialize).parameters.map(&:last)
    args = initialize_parameters.map do |param|
      function_output = options[param]
      function_output ||= factory.send(param) # may have problems optional params
      function_output
    end

    factory_instance = ChairsFactory::FactoryInstance.new( factory_name, Hash[initialize_parameters.zip(args)] )

    callback(factory_name, :build, factory_instance) do 
      factory_instance.activate_object
    end
    
    factory_instance.linked_object
  end

  def factories
    @@factories
  end
end
