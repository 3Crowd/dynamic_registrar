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

end
