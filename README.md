The capability registrar allows modules to register versioned callbacks. Callbacks may only be
registered once per registration namespace. If multiple callback registration is attempted a
RegistrationConflictError will be raised.

Example
=======

    master_registrar = Registrar.new

    master_registrar.default_registration_namespace = :test

callback procs should avoid side effects
The register call will throw an exception if you don't pass in a second argument containing the registration namespace,
unless the default_registration_namespace attribute is set

    master_registrar.register :awesome_called do | awesome_data |
      awesome_data
    end

    master_registrar.register :awesome_called, :something_else do | awesome_data |
      "And now for something completely different"
    end

dispatches to all registration namespaces in undefined order for all :awesome_called registered callbacks
returns a Hash with the registration_namespace of the callback as the key, and the value is the value returned by
the callback function.

calling

    master_registrar.dispatch :awesome_called, :with_data => { :some_lol_data => :wow_cool }

returns

    { :test => { :some_lol_data => :wow_cool }, :something_else => "And now for something completely different" }


dispatches to named registration namespaces return a Hash with the registration_namespace as the key, and the value is the
value returned by the callback function, or an empty hash if the callback function is not registered

    master_registrar.dispatch :awesome_called, :in_registration_namespace => :test, :with_data => { :some_lol_data => :omg_specific_cool }

returns

    { :test => { :some_lol_data => :omg_specific_cool } }
