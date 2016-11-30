# factory_boy_ruby
Generate testing instances for non-model classes

## Installation 

add the following in the gemfile 
```
gem 'factory_boy_ruby'
```
or download it manually through the shell
```
gem install factory_boy_ruby
```

## Getting started
first you need to require it preferrely requiring it in the spec_helper
```
# spec/spec_helper.rb
require 'factory_boy'
```
and make a folder to put your factory code in for eg. spec/factory_boy/factories, if you're using factory_girl load these factories
after factory_girl factories to be able to use them.
you can add these lines in the spec_helper to be able to load them
```
# spec/spec_helper.rb
Dir['./spec/factory_boy/factories/**/*.rb'].each { |f| require f }
```
or loading it in the factory_girl initializer will work as well

```
# initializer/factory_girl.rb
FactoryGirl.definition_file_paths.push(Pathname.new (File.join(Rails.root, 'spec/factory_boy')))
```

## Sample
sample factory for class Registration
```
class Registration
  def initialize(name, email, password, country) ;
  def signup() ;
end
```
```
# factory_boy/factories/registration_factory.rb
FactoryBoy.define do
  factory :registration, class: Registration do
    name { "toto" }
    email { Faker::Internet.email }
    password {  Token.generate() }
    factory_girl :country

    before(:build) do
      FactoryGirl.create(:user, name: self.name ,email: self.email, password: self.password, country_id: self.country.id)
    end
  end
end
```
