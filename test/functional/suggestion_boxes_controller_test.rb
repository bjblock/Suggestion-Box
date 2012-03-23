require 'test_helper'

class SuggestionBoxesControllerTest < ActionController::TestCase
  setup do
    @suggestion_box = suggestion_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suggestion_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create suggestion_box" do
    assert_difference('SuggestionBox.count') do
      post :create, suggestion_box: @suggestion_box.attributes
    end

    assert_redirected_to suggestion_box_path(assigns(:suggestion_box))
  end

  test "should show suggestion_box" do
    get :show, id: @suggestion_box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @suggestion_box
    assert_response :success
  end

  test "should update suggestion_box" do
    put :update, id: @suggestion_box, suggestion_box: @suggestion_box.attributes
    assert_redirected_to suggestion_box_path(assigns(:suggestion_box))
  end

  test "should destroy suggestion_box" do
    assert_difference('SuggestionBox.count', -1) do
      delete :destroy, id: @suggestion_box
    end

    assert_redirected_to suggestion_boxes_path
  end
end
