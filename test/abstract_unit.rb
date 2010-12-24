require 'cover_me' unless ENV['TEST_ENV_NUMBER'] # don't require coverage tracer when running in parallel
require 'minitest/autorun'
