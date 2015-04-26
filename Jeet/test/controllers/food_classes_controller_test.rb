require 'test_helper'

class FoodClassesControllerTest < ActionController::TestCase
  setup do
    @food_class = food_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_class" do
    assert_difference('FoodClass.count') do
      post :create, food_class: { name: @food_class.name }
    end

    assert_redirected_to food_class_path(assigns(:food_class))
  end

  test "should show food_class" do
    get :show, id: @food_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_class
    assert_response :success
  end

  test "should update food_class" do
    patch :update, id: @food_class, food_class: { name: @food_class.name }
    assert_redirected_to food_class_path(assigns(:food_class))
  end

  test "should destroy food_class" do
    assert_difference('FoodClass.count', -1) do
      delete :destroy, id: @food_class
    end

    assert_redirected_to food_classes_path
  end
end
