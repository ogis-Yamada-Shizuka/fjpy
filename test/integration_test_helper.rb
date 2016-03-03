# test/acceptance_test_helper.rb
#require 'minitest-metadata'
require "test_helper"

class AcstIntegrationTest < ActiveSupport::TestCase
  include Minitest::Capybara::Behaviour

  # before do
    # if metadata[:js]
    #  Capybara.javascript_driver = :webkit
    #  Capybara.current_driver = Capybara.javascript_driver
    # else
    #  Capybara.current_driver = Capybara.default_driver
    # end
  # end
  
end