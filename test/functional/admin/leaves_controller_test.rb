require 'test_helper'

class Admin::LeavesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Leaf.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Leaf.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Leaf.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_leaf_url(assigns(:leaf))
  end

  def test_edit
    get :edit, :id => Leaf.first
    assert_template 'edit'
  end

  def test_update_invalid
    Leaf.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Leaf.first
    assert_template 'edit'
  end

  def test_update_valid
    Leaf.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Leaf.first
    assert_redirected_to admin_leaf_url(assigns(:leaf))
  end

  def test_destroy
    leaf = Leaf.first
    delete :destroy, :id => leaf
    assert_redirected_to admin_leaves_url
    assert !Leaf.exists?(leaf.id)
  end
end
