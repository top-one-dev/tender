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
    unless current_company.nil?
      @requests = current_company.requests
      @users    = current_company.users
    else
      @requests = @users = []
    end
    redirect_to root_path if @requests.empty?
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
