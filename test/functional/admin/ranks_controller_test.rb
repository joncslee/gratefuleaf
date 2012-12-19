require 'test_helper'

class Admin::RanksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Rank.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Rank.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Rank.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_rank_url(assigns(:rank))
  end

  def test_edit
    get :edit, :id => Rank.first
    assert_template 'edit'
  end

  def test_update_invalid
    Rank.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Rank.first
    assert_template 'edit'
  end

  def test_update_valid
    Rank.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Rank.first
    assert_redirected_to admin_rank_url(assigns(:rank))
  end

  def test_destroy
    rank = Rank.first
    delete :destroy, :id => rank
    assert_redirected_to admin_ranks_url
    assert !Rank.exists?(rank.id)
  end
end
