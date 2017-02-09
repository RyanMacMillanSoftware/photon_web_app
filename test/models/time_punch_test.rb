require 'test_helper'

class TimePunchTest < ActiveSupport::TestCase
  
  def setup
    @timepunch = TimePunch.new(name: "Example User", email: "user@example.com", 
    check_in: DateTime.current(), check_out: DateTime.current())
  end

  test "should be valid" do
    assert @timepunch.valid?
  end
  
  test "name should be present" do
    @timepunch.name = "     "
    assert_not @timepunch.valid?
  end
  
end
