require 'abstract_unit'
require 'dynamic_registrar/errors/registration_conflict_error'

class DynamicRegistrarErrorsRegistrationConflictErrorTest < MiniTest::Unit::TestCase
  
  def test_ensure_defines_registration_conflict_error_on_inclusion
    refute DynamicRegistrar::Errors::RegistrationConflictError.nil?, 'Including file did not define RegistrationConflictError'
  end
  
end
