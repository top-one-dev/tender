require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get dashboard_request_url
    assert_response :success
  end

  test "should get requisition" do
    get dashboard_requisition_url
    assert_response :success
  end

  test "should get supplier" do
    get dashboard_supplier_url
    assert_response :success
  end

  test "should get activity" do
    get dashboard_activity_url
    assert_response :success
  end

  test "should get message" do
    get dashboard_message_url
    assert_response :success
  end

  test "should get report" do
    get dashboard_report_url
    assert_response :success
  end

end
