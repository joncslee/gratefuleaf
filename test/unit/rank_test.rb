require 'test_helper'

class RankTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Rank.new.valid?
  end
end
