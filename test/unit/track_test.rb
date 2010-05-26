require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Track.new.valid?
  end
end
