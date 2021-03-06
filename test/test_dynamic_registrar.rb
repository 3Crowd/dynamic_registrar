require 'abstract_unit'
require 'dynamic_registrar'

class DynamicRegistrarTest < MiniTest::Unit::TestCase

  def test_inclusion_of_version
    refute DynamicRegistrar::Version.nil?, 'DynamicRegistrar does not include version module'
  end
  
  def test_inclusion_of_registrar
    refute DynamicRegistrar::Registrar.nil?, 'DynamicRegistrar does not include registrar module'
  end
  
end

