module FactoryCallbacks
  @@callbacks ||= {}

  def register_callback(factory_name, execution_precedence, on_call, &block)
    @@callbacks[factory_name] ||= {}
    @@callbacks[factory_name][execution_precedence] ||= {}
    @@callbacks[factory_name][execution_precedence][on_call] = block
  end

  def get_callback(factory_name, execution_precedence, on_call)
    if @@callbacks.try(:[], factory_name).try(:[], execution_precedence).try(:[], on_call)
      @@callbacks[factory_name][execution_precedence][on_call] 
    end
  end

  def run_callback(factory_name, execution_precedence, on_call, block_scope)
    callback = get_callback(factory_name, execution_precedence, on_call)
    block_scope.instance_eval(&callback) if callback
  end

  def callback(factory_name, on_call, block_scope, &block)
    run_callback(factory_name, :before, on_call, block_scope)
    block.call
    run_callback(factory_name, :after, on_call, block_scope)
  end
end

