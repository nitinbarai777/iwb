class ChartsController < ApplicationController

  def show
    charts = current_user.user_groups.map{|ug| ug.charts}.flatten
    @chart = Chart.find_by(name: params[:name])
    if charts.include? @chart
      @chart_users = @chart.chart_users.order(rank: :desc)
      @current_user_index = @chart_users.index(@chart_users.find_by(user: current_user))
      @current_user_rank = @current_user_index.present? ? @current_user_index + 1 : 0 
    else
      redirect_to root_url unless @chart.present?
    end
  end

end
