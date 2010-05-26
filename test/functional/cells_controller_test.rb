require 'test_helper'

class CellsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Cell.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Cell.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Cell.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cell_url(assigns(:cell))
  end
  
  def test_edit
    get :edit, :id => Cell.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Cell.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Cell.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Cell.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Cell.first
    assert_redirected_to cell_url(assigns(:cell))
  end
  
  def test_destroy
    cell = Cell.first
    delete :destroy, :id => cell
    assert_redirected_to cells_url
    assert !Cell.exists?(cell.id)
  end
end
