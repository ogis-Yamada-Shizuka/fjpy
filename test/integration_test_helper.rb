# test/acceptance_test_helper.rb
#require 'minitest-metadata'
require "test_helper"
require 'capybara-webkit'

Capybara.javascript_driver = :webkit

class AcstIntegrationTest < ActiveSupport::TestCase
  include Minitest::Capybara::Behaviour
  
end