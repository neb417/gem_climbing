class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:id])
    
    if params[:alphabetize]
      @crag_routes = @crag.routes.order(:route_name)
    elsif params[:pitches]
      @crag_routes = @crag.routes.where("pitches >= ?", params[:pitches].to_i)
    else
      @crag_routes = @crag.routes
    end
  end

  def new
    @crag = Crag.find(params[:id])
  end

  def create
    crag = Crag.find(params[:id])
    crag.routes.create!(route_params)
    redirect_to "/crags/#{crag.id}/routes"
  end

  private

  def route_params
    params.permit(:route_name, :sport_route, :trad_route, :pitches, :grade)
  end
end