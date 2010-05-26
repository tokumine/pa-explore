require 'test_helper'

class CellTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Cell.new.valid?
  end
end
