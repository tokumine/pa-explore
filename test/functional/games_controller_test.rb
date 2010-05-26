require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
end
