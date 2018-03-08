class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company

  def trequest
  end

  def requisition
  end

  def supplier
  end

  def activity
  end

  def message
  end

  def report
  end

  private
  def set_company
    if current_user.companies.exists?
      session[:current_company_id] = current_user.companies.first.id if session[:current_company_id].nil?
    else
      session[:current_company_id] = 0
    end 
  end

end
