require 'abstract_unit'
require 'dynamic_registrar/registrar'

class DynamicRegistrarRegistrarTest < MiniTest::Unit::TestCase

  def test_has_default_registration_namespace_attribute
    assert_includes DynamicRegistrar::Registrar.instance_methods, :default_registration_namespace
    assert_includes DynamicRegistrar::Registrar.instance_methods, 'default_registration_namespace='.to_sym
  end

  def test_has_register_bang_method
    assert_includes DynamicRegistrar::Registrar.instance_methods, 'register!'.to_sym
  end
  
  def test_has_registered_callbacks_reader
    assert_includes DynamicRegistrar::Registrar.instance_methods, :registered_callbacks
    refute_includes DynamicRegistrar::Registrar.instance_methods, 'registered_callbacks='.to_sym
  end

end
