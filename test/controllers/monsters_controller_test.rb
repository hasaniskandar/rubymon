require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user    = users(:user_3)
    @monster = monsters(:monster_3_1)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monsters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monster" do
    assert_difference('Monster.count') do
      post :create, monster: { element: @monster.element, name: 'new name', power: @monster.power }
    end

    assert_redirected_to monster_path(assigns(:monster))
  end

  test "should show monster" do
    get :show, id: @monster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monster
    assert_response :success
  end

  test "should update monster" do
    patch :update, id: @monster, monster: { element: @monster.element, name: 'updated name', power: @monster.power }
    assert_redirected_to monster_path(assigns(:monster))
  end

  test "should destroy monster" do
    assert_difference('Monster.count', -1) do
      delete :destroy, id: @monster
    end

    assert_redirected_to monsters_path
  end

end
