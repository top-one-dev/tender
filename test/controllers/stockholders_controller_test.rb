require 'test_helper'

class StockholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stockholder = stockholders(:one)
  end

  test "should get index" do
    get stockholders_url
    assert_response :success
  end

  test "should get new" do
    get new_stockholder_url
    assert_response :success
  end

  test "should create stockholder" do
    assert_difference('Stockholder.count') do
      post stockholders_url, params: { stockholder: { email: @stockholder.email, job: @stockholder.job, name: @stockholder.name, phone: @stockholder.phone, requisition_id: @stockholder.requisition_id } }
    end

    assert_redirected_to stockholder_url(Stockholder.last)
  end

  test "should show stockholder" do
    get stockholder_url(@stockholder)
    assert_response :success
  end

  test "should get edit" do
    get edit_stockholder_url(@stockholder)
    assert_response :success
  end

  test "should update stockholder" do
    patch stockholder_url(@stockholder), params: { stockholder: { email: @stockholder.email, job: @stockholder.job, name: @stockholder.name, phone: @stockholder.phone, requisition_id: @stockholder.requisition_id } }
    assert_redirected_to stockholder_url(@stockholder)
  end

  test "should destroy stockholder" do
    assert_difference('Stockholder.count', -1) do
      delete stockholder_url(@stockholder)
    end

    assert_redirected_to stockholders_url
  end
end
