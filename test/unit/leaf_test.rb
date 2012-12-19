require 'test_helper'

class LeafTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Leaf.new.valid?
  end
end
