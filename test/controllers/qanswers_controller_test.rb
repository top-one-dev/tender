require 'test_helper'

class QanswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qanswer = qanswers(:one)
  end

  test "should get index" do
    get qanswers_url
    assert_response :success
  end

  test "should get new" do
    get new_qanswer_url
    assert_response :success
  end

  test "should create qanswer" do
    assert_difference('Qanswer.count') do
      post qanswers_url, params: { qanswer: { answer: @qanswer.answer, attach: @qanswer.attach, question_id: @qanswer.question_id, supplier_id: @qanswer.supplier_id } }
    end

    assert_redirected_to qanswer_url(Qanswer.last)
  end

  test "should show qanswer" do
    get qanswer_url(@qanswer)
    assert_response :success
  end

  test "should get edit" do
    get edit_qanswer_url(@qanswer)
    assert_response :success
  end

  test "should update qanswer" do
    patch qanswer_url(@qanswer), params: { qanswer: { answer: @qanswer.answer, attach: @qanswer.attach, question_id: @qanswer.question_id, supplier_id: @qanswer.supplier_id } }
    assert_redirected_to qanswer_url(@qanswer)
  end

  test "should destroy qanswer" do
    assert_difference('Qanswer.count', -1) do
      delete qanswer_url(@qanswer)
    end

    assert_redirected_to qanswers_url
  end
end
