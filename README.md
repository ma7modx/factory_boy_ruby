# factory_boy_ruby
Generate testing instances for non-model classes

## Installation 

Add the following in the gemfile 
```ruby
gem 'factory_boy_ruby'
```
and run ``` bundle install ```

Or install it manually from the shell
```bash
gem install factory_boy_ruby
```

## Getting started
First you need to require it, preferred doing this in the spec_helper
```ruby
# spec/spec_helper.rb
require 'factory_boy'
```
and make a folder to put your factory code in eg. spec/factory_boy/factories, if you're using factory_girl load these factories after factory_girl factories to be able to use them.
you can add these lines in the spec_helper to be able to load them
```ruby
# spec/spec_helper.rb
Dir['./spec/factory_boy/factories/**/*.rb'].each { |f| require f }
```
or loading it in the factory_girl initializer would work as well

```ruby
# initializer/factory_girl.rb
FactoryGirl.definition_file_paths.push(Pathname.new (File.join(Rails.root, 'spec/factory_boy')))
```

## Sample
sample factory for class VehilcesRetriever
```ruby
class VehilcesRetriever
  def initialize(provider_company, country, city, vehicle_type) ;
end
```
```ruby
# factory_boy/factories/vehicles_retriever.rb
FactoryBoy.define do
  factory :vehicles_retriever, class: VehilcesRetriever do
    factory_girl :provider_company, factory: :company, create: true
    factory_girl :country
    vehicle_type { VehicleTypes.all.sample }

    before(:build) do
      FactoryGirl.create(:vehicle, provider_company: self.provider_company ,country: self.country, vehicle_type: self.vehicle_type)
    end
  end
end
```

```ruby
FactoryBoy.build(:vehicles_retriever)
```
