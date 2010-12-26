require 'abstract_unit'
require 'dynamic_registrar/registrar'

class DynamicRegistrarRegistrarTest < MiniTest::Unit::TestCase

  def test_ensure_includes_errors
    refute DynamicRegistrar::Errors::RegistrationConflictError.nil?, 'Including file did not define RegistrationConflictError'  
  end
  
  def test_has_default_registration_namespace_reader
    assert_includes DynamicRegistrar::Registrar.instance_methods, :default_registration_namespace
  end

  def test_has_register_bang_method
    assert_includes DynamicRegistrar::Registrar.instance_methods, 'register!'.to_sym
  end
  
  def test_has_registered_callbacks_reader
    assert_includes DynamicRegistrar::Registrar.instance_methods, :registered_callbacks
    refute_includes DynamicRegistrar::Registrar.instance_methods, 'registered_callbacks='.to_sym
  end
  
  def test_has_registration_query_method
    assert_includes DynamicRegistrar::Registrar.instance_methods, 'registered?'.to_sym
    assert_includes DynamicRegistrar::Registrar.instance_methods, 'registered_in_namespace?'.to_sym
  end
  
  def test_has_dispatch_method
    assert_includes DynamicRegistrar::Registrar.instance_methods, :dispatch
  end
  
  def test_register_method_adds_given_parameters_to_registered_callbacks
    registrar = DynamicRegistrar::Registrar.new :test_namespace
    assert_empty registrar.registered_callbacks
    registrar.register! :test_callback do
      # empty block to match interface
    end
    assert registrar.registered?(:test_callback), 'Test callback was not registered in registrar even though we attempted to do so'
    assert registrar.registered_in_namespace?(:test_callback, :test_namespace), 'Test callback in namespace test_namespace was not registered in the registrar even though we attempted to do so'
  end
  
  def test_registered_method_does_not_report_registered_callback_when_no_callback_is_registered
    registrar = DynamicRegistrar::Registrar.new(:default_namespace)
    refute registrar.registered?(:nonexistent_callback), 'Registrar#registered? returned true for a non-registered callback in any namespace'
    refute registrar.registered_in_namespace?(:nonexistent_callback, :nonexistant_namespace), 'Registrar#registered_in_namespace? returned true for non-registered callback in non-existant namespace'
  end
  
  def test_attempting_to_double_register_in_same_namespace_results_in_exception
    registrar = DynamicRegistrar::Registrar.new(:default)
    registrar.register! :test_callback do # in :default namespace
      #empty block to match interface
    end
    assert_raises DynamicRegistrar::Errors::RegistrationConflictError do
      registrar.register! :test_callback do # in :default namespace
        #empty block to match interface
      end
    end
  end
  
  def test_dispatching_call_to_one_named_callback_dispatches_to_all_registered_namespaces
    registrar = DynamicRegistrar::Registrar.new(:default)
    test_callback_namespace_one_called = false
    registrar.register! :test_callback, :test_namespace_one do
      test_callback_namespace_one_called = true
    end
    test_callback_namespace_two_called = false
    registrar.register! :test_callback, :test_namespace_two do
      test_callback_namespace_two_called = true
    end
    registrar.dispatch :test_callback
    assert test_callback_namespace_one_called, 'Dispatching to test_callback with all namespaces did not run callback for namespace_one'
    assert test_callback_namespace_two_called, 'Dispatching to test_callback with all namespaces did not run callback for namespace_two'
  end
  
  def test_dispatching_call_to_one_named_callback_in_named_namespace_dispatches_to_only_that_callback
    registrar = DynamicRegistrar::Registrar.new(:default)
    test_callback_namespace_one_called = false
    registrar.register! :test_callback, :test_namespace_one do
      test_callback_namespace_one_called = true
    end
    
    test_callback_namespace_two_called = false
    registrar.register! :test_callback, :test_namespace_two do
      test_callback_namespace_two_called = true
    end
    
    registrar.dispatch :test_callback, :test_namespace_one
    
    assert test_callback_namespace_one_called, 'Dispatching to test_callback with test_namespace_one namespace did not run callback for namespace_one'
    refute test_callback_namespace_two_called, 'Dispatching to test_callback with test_namespace_one namespace called callback for namespace_two'
  end
  
  def test_callbacks_return_output_in_known_format
    registrar = DynamicRegistrar::Registrar.new(:default)
    registrar.register! :test_callback, :test_namespace_one do
      :aishgaoirhvoi43
    end
    registrar.register! :test_callback, :test_namespace_two do
      :sdo8ivh90r8h034c
    end
    
    responses = registrar.dispatch :test_callback
    
    assert_includes responses.keys, :test_namespace_one
    assert_includes responses.keys, :test_namespace_two
    assert_includes responses[:test_namespace_one].keys, :test_callback
    assert_includes responses[:test_namespace_two].keys, :test_callback
    assert_equal responses[:test_namespace_one][:test_callback], :aishgaoirhvoi43
    assert_equal responses[:test_namespace_two][:test_callback], :sdo8ivh90r8h034c
  end

end
