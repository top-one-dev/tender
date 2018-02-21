require 'test_helper'

class IanswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ianswer = ianswers(:one)
  end

  test "should get index" do
    get ianswers_url
    assert_response :success
  end

  test "should get new" do
    get new_ianswer_url
    assert_response :success
  end

  test "should create ianswer" do
    assert_difference('Ianswer.count') do
      post ianswers_url, params: { ianswer: { item_id: @ianswer.item_id, quantity: @ianswer.quantity, supplier_id: @ianswer.supplier_id, unit_price: @ianswer.unit_price } }
    end

    assert_redirected_to ianswer_url(Ianswer.last)
  end

  test "should show ianswer" do
    get ianswer_url(@ianswer)
    assert_response :success
  end

  test "should get edit" do
    get edit_ianswer_url(@ianswer)
    assert_response :success
  end

  test "should update ianswer" do
    patch ianswer_url(@ianswer), params: { ianswer: { item_id: @ianswer.item_id, quantity: @ianswer.quantity, supplier_id: @ianswer.supplier_id, unit_price: @ianswer.unit_price } }
    assert_redirected_to ianswer_url(@ianswer)
  end

  test "should destroy ianswer" do
    assert_difference('Ianswer.count', -1) do
      delete ianswer_url(@ianswer)
    end

    assert_redirected_to ianswers_url
  end
end
