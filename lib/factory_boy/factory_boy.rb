require_relative 'factory_declarator'
require_relative 'factory_callbacks'

module FactoryBoy
  extend FactoryDeclarator
  extend FactoryCallbacks
	
  require_relative 'factory'
  require_relative 'factory_instance'
end

