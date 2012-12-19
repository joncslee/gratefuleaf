require 'test_helper'

class BadgeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Badge.new.valid?
  end
end
