require 'thread'

require 'dynamic_registrar/errors/registration_conflict_error'

module DynamicRegistrar
  # Controls the registration and dispatching of callbacks
  class Registrar
    
    # Mutex to provide for no double or overwritten registration guarantee even in multithreaded environments
    # @private
    @@registration_guard = Mutex.new

    # The default namespace used when calling Registrar#register! without specifying a namespace
    attr_reader :default_registration_namespace
    
    # The collection of callbacks currently registered within the Registrar
    def registered_callbacks
      @@registration_guard.synchronize do
        @registered_callbacks
      end
    end
    
    # Create a new DynamicRegistrar::Registrar
    # @param [ Symbol ] default_registration_namespace The default namespace in which to register callbacks. Should not be set to nil.
    def initialize default_registration_namespace
      @default_registration_namespace = default_registration_namespace
      @registered_callbacks = Hash.new
    end
    
    # Register a new callback procedure. This method is thread-safe.
    # @param [ Symbol ] name The name of the callback to register
    # @param [ Symbol ] namespace The namespace in which to register the callback
    def register! name, namespace = @default_registration_namespace, &callback_proc
      @@registration_guard.synchronize do
        raise Errors::RegistrationConflictError if registered_in_namespace? name, namespace
        @registered_callbacks[namespace] ||= Hash.new
        @registered_callbacks[namespace][name] = callback_proc
      end
    end
    
    # Dispatch message to given callback. All named callbacks matching the name will 
    # be run in all namespaces in indeterminate order
    # @param [ Symbol ] name The name of the callback 
    # @param [ Symbol ] namespace The namespace in which the named callback should be found. Optional, if omitted then all matching named callbacks in all namespaces will be executed
    # @return [ Hash ] A hash whose keys are the namespaces in which callbacks were executed, and whose values are the results of those executions. If empty, then no callbacks were executed.
    def dispatch name, namespace = nil
      responses = Hash.new
      namespaces_to_search = namespace ? [namespace] : namespaces
      namespaces_to_search.each do |namespace|
        responses[namespace] ||= Hash.new
        responses[namespace][name] = @registered_callbacks[namespace][name].call if @registered_callbacks[namespace].has_key?(name)
      end
      responses
    end
    
    # Query if a callback of given name is registered in any namespace
    # @param [ Symbol ] name The name of the callback to check
    def registered? name
      registration_map = namespaces.map do |namespace|
        registered_in_namespace? name, namespace
      end
      registration_map.any?
    end
    
    # Query if a callback of given name is registered in given namespace
    # @param [ Symbol ] name The name of the callback to check
    # @param [ Symbol ] namespace The name of the namespace in which to check
    def registered_in_namespace? name, namespace
      @registered_callbacks.has_key?(namespace) && @registered_callbacks[namespace].has_key?(name)
    end
    
    private
    
    def namespaces
      @registered_callbacks.keys
    end
    
    
  end
end
