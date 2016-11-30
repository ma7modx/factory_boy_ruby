require 'rubygems' 
require 'rake'
require 'echoe'

Echoe.new('factory_boy', '0.1.0') do |p|
  p.description    = "Generate testing instances for the non-model classes	"
  p.url            = "http://github.com/ma7modx/factory_boy"
  p.author         = "Mahmoud Afify"
  p.email          = "ma7modx@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
