require 'test_helper'

class ClassificationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Classification.new.valid?
  end
end
