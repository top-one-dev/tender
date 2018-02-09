require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notification = notifications(:one)
  end

  test "should get index" do
    get notifications_url
    assert_response :success
  end

  test "should get new" do
    get new_notification_url
    assert_response :success
  end

  test "should create notification" do
    assert_difference('Notification.count') do
      post notifications_url, params: { notification: { changed_request: @notification.changed_request, invit_request: @notification.invit_request, join_company: @notification.join_company, label_tender_scoring: @notification.label_tender_scoring, messages: @notification.messages, messages_requisition: @notification.messages_requisition, new_bid: @notification.new_bid, not_participate_request: @notification.not_participate_request, participate_request: @notification.participate_request, reject_compay: @notification.reject_compay, reminder_end: @notification.reminder_end, request_decision: @notification.request_decision, submitted_requisition: @notification.submitted_requisition, user_id: @notification.user_id } }
    end

    assert_redirected_to notification_url(Notification.last)
  end

  test "should show notification" do
    get notification_url(@notification)
    assert_response :success
  end

  test "should get edit" do
    get edit_notification_url(@notification)
    assert_response :success
  end

  test "should update notification" do
    patch notification_url(@notification), params: { notification: { changed_request: @notification.changed_request, invit_request: @notification.invit_request, join_company: @notification.join_company, label_tender_scoring: @notification.label_tender_scoring, messages: @notification.messages, messages_requisition: @notification.messages_requisition, new_bid: @notification.new_bid, not_participate_request: @notification.not_participate_request, participate_request: @notification.participate_request, reject_compay: @notification.reject_compay, reminder_end: @notification.reminder_end, request_decision: @notification.request_decision, submitted_requisition: @notification.submitted_requisition, user_id: @notification.user_id } }
    assert_redirected_to notification_url(@notification)
  end

  test "should destroy notification" do
    assert_difference('Notification.count', -1) do
      delete notification_url(@notification)
    end

    assert_redirected_to notifications_url
  end
end
