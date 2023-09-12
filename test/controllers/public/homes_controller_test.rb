require "test_helper"

class Public::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_homes_index_url
    assert_response :success
  end
end
