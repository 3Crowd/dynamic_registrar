module DynamicRegistrar
  # Encapsulates errors thrown by DynamicRegistrar
  module Errors
    # Defines a registration conflict error. This typically occurs when an attempt
    # has been made to register a callback with the name of an existing callback
    # in the scoped namespace.
    class RegistrationConflictError < StandardError
    end
  end
end
