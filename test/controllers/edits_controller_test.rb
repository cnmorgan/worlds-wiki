require 'test_helper'

class EditsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get edits_index_url
    assert_response :success
  end

end
