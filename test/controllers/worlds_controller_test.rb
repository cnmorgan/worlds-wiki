require 'test_helper'

class WorldsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get worlds_new_url
    assert_response :success
  end

  test "should get create" do
    get worlds_create_url
    assert_response :success
  end

  test "should get update" do
    get worlds_update_url
    assert_response :success
  end

  test "should get edit" do
    get worlds_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get worlds_destroy_url
    assert_response :success
  end

  test "should get show" do
    get worlds_show_url
    assert_response :success
  end

end
