module DynamicRegistrar
  # Release version, set on revision control release branches as a separate commit
  # after branching so that trunk patches can be easily backported.
  #
  # This is always 0.0.developer on master/mainline, refer to the HEAD commit for
  # the version number instead.
  module Version
    # Incremented on breaking changes (breaks serialized data and/or removes deprecated APIs, for example)
    MAJOR = "0"
    # Incremented for major feature releases that do not break backwards compatibility
    MINOR = "0"
    # Incremented for minor fixes and updates
    PATCH = "developer"

    # Converts the version number held in this module to a human readable string
    # @return [ String ] The BinData version release
    def self.inspect
      [MAJOR,MINOR,PATCH].join('.')
    end

  end
end
