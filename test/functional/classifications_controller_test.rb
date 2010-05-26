require 'test_helper'

class ClassificationsControllerTest < ActionController::TestCase
  def test_update_invalid
    Classification.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Classification.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Classification.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Classification.first
    assert_redirected_to root_url
  end
end
