module DynamicRegistrar
  # Controls the registration and dispatching of callbacks
  class Registrar
    
    # The default namespace used when calling Registrar#register! without specifying a namespace
    attr_accessor :default_registration_namespace
    attr_reader :registered_callbacks
    
    # Create a new DynamicRegistrar::Registrar
    def initialize
      @registered_callbacks = Hash.new
    end
    
    # Register a new callback procedure
    def register!
    end
    
    private
    
    def namespaces
      @registered_callbacks.keys
    end
    
    
  end
end
