require 'test_helper'

class TimePunchTest < ActiveSupport::TestCase
  
  def setup
    @timepunch = time_punches(:one)
  end

  test "should be valid" do
    assert @timepunch.valid?
  end
  
  test "name should be present" do
    @timepunch.name = "     "
    assert_not @timepunch.valid?
  end
  
end
