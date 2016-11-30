require_relative '../chairs_factory'

module FactoryCustomizer
  def set_method(name, options = {}, &method_return_block)
    method_return_block ||= Proc.new { options[:return] }
    proc = Proc.new { |name, method_return|
      self.define_singleton_method(name) do
        method_return.call
      end
    }
    self.instance_exec(name, method_return_block, &proc)
  end

  def factory_girl(name, options = {}, &block)
    build_or_create = !options[:create]
    factory_name = options[:factory] || name
    factory_call = Proc.new {
      build_or_create ? FactoryGirl.build(factory_name) : FactoryGirl.create(factory_name)
    }
    set_method(name, {}, &(block || factory_call))
  end

  def register_callback(execution_precedence, *on_calls, &block)
    on_calls.each do |on_call|
      ChairsFactory.register_callback(self.factory_name, execution_precedence, on_call, &block)
    end
  end

  [:after, :before].each { |execution_precedence|
    define_method(execution_precedence) do |*on_calls, &block|
      register_callback(execution_precedence, *on_calls, &block)
    end
  }
end
