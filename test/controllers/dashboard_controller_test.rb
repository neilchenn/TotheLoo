require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get my_favorites" do
    get dashboard_my_favorites_url
    assert_response :success
  end
end
