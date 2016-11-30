require_relative 'factory_boy/factory_declarator'
require_relative 'factory_boy/factory_callbacks'

module FactoryBoy
  extend FactoryDeclarator
  extend FactoryCallbacks
	
  require_relative 'factory_boy/factory'
  require_relative 'factory_boy/factory_instance'
end

