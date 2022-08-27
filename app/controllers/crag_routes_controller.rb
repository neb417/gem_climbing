class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:id])
    @crag_routes = @crag.routes
  end
  
  def new
    @crag = Crag.find(params[:id])
  end
  
  def create
    crag = Crag.find(params[:id])
    route = crag.routes.create!(route_params)
    redirect_to "/crags/#{crag.id}/routes"
  end

private
  def route_params
    params.permit(:route_name, :sport_route, :trad_route, :pitches, :grade)
  end
end