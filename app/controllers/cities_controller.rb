class CitiesController < ApplicationController

  def show
    @city = City.find_by(name: params[:name])
    redirect_to root_url unless @city.present?
  end

end
