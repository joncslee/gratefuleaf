require 'test_helper'

class Admin::BadgesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Badge.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Badge.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Badge.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_badge_url(assigns(:badge))
  end

  def test_edit
    get :edit, :id => Badge.first
    assert_template 'edit'
  end

  def test_update_invalid
    Badge.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Badge.first
    assert_template 'edit'
  end

  def test_update_valid
    Badge.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Badge.first
    assert_redirected_to admin_badge_url(assigns(:badge))
  end

  def test_destroy
    badge = Badge.first
    delete :destroy, :id => badge
    assert_redirected_to admin_badges_url
    assert !Badge.exists?(badge.id)
  end
end
