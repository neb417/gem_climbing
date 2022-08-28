class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:id])

    if params[:alphabetize] == "true"
      @crag_routes = @crag.routes.order(:route_name)
    else
      @crag_routes = @crag.routes
    end
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