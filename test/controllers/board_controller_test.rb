require 'test_helper'

class BoardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get board_show_url
    assert_response :success
  end

end
