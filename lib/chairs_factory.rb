require_relative 'chairs_factory/factory_declarator'
require_relative 'chairs_factory/factory_callbacks'

module ChairsFactory
  extend FactoryDeclarator
  extend FactoryCallbacks
	
  require_relative 'chairs_factory/factory'
  require_relative 'chairs_factory/factory_instance'
end

