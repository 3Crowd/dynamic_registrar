require 'abstract_unit'
require 'dynamic_registrar/version'

class DynamicRegistrarVersionTest < MiniTest::Unit::TestCase
  
  def test_inspect_is_not_dynamic_registrar_version
    refute DynamicRegistrar::Version.inspect == 'DynamicRegistrar::Version', 'DynamicRegistrar Version is DynamicRegistrar::Version, inspect is probably not defined properly'
  end
  
  def test_inspect_return_value_is_not_same_as_to_s
    refute DynamicRegistrar::Version.inspect == DynamicRegistrar::Version.to_s, 'DynamicRegistrar Version to_s equaled DynamicRegistrar Version inspect!'
  end
  
  def test_to_s_returns_dynamic_registrar_version_module_name
    assert DynamicRegistrar::Version.to_s == 'DynamicRegistrar::Version', 'DynamicRegistrar::Version.to_s did not return DynamicRegistrar::Version, someone probably adjusted it to display the version string.'
  end
  
  def test_inspect_converts_version_properly
    assert [DynamicRegistrar::Version::MAJOR, DynamicRegistrar::Version::MINOR, DynamicRegistrar::Version::PATCH].join('.') == DynamicRegistrar::Version.inspect, 'DynamicRegistrar::Version does not inspect properly'
  end

end
