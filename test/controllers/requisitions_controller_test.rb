require 'test_helper'

class RequisitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requisition = requisitions(:one)
  end

  test "should get index" do
    get requisitions_url
    assert_response :success
  end

  test "should get new" do
    get new_requisition_url
    assert_response :success
  end

  test "should create requisition" do
    assert_difference('Requisition.count') do
      post requisitions_url, params: { requisition: { additional_document: @requisition.additional_document, budget: @requisition.budget, budget_currency: @requisition.budget_currency, company_id: @requisition.company_id, contact_department: @requisition.contact_department, contact_email: @requisition.contact_email, contact_manager: @requisition.contact_manager, contact_name: @requisition.contact_name, contact_phone: @requisition.contact_phone, cost_center: @requisition.cost_center, delivery_address: @requisition.delivery_address, delivery_date: @requisition.delivery_date, description: @requisition.description, name: @requisition.name, project: @requisition.project, quantity: @requisition.quantity, status: @requisition.status, user_id: @requisition.user_id } }
    end

    assert_redirected_to requisition_url(Requisition.last)
  end

  test "should show requisition" do
    get requisition_url(@requisition)
    assert_response :success
  end

  test "should get edit" do
    get edit_requisition_url(@requisition)
    assert_response :success
  end

  test "should update requisition" do
    patch requisition_url(@requisition), params: { requisition: { additional_document: @requisition.additional_document, budget: @requisition.budget, budget_currency: @requisition.budget_currency, company_id: @requisition.company_id, contact_department: @requisition.contact_department, contact_email: @requisition.contact_email, contact_manager: @requisition.contact_manager, contact_name: @requisition.contact_name, contact_phone: @requisition.contact_phone, cost_center: @requisition.cost_center, delivery_address: @requisition.delivery_address, delivery_date: @requisition.delivery_date, description: @requisition.description, name: @requisition.name, project: @requisition.project, quantity: @requisition.quantity, status: @requisition.status, user_id: @requisition.user_id } }
    assert_redirected_to requisition_url(@requisition)
  end

  test "should destroy requisition" do
    assert_difference('Requisition.count', -1) do
      delete requisition_url(@requisition)
    end

    assert_redirected_to requisitions_url
  end
end
