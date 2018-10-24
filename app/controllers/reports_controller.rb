class ReportsController < ApplicationController
  def index
    @teams = Report.all(session[:timecrowd_token])
  end

  def show
    @report = Report.find(session[:timecrowd_token], params[:id])
  end
end
