class RoutesController < ApplicationController
  def index
    @routes = Route.where(sport_route: true)
  end
  
  def show
    @route = Route.find(params[:id])
  end

  def edit
    @route = Route.find(params[:id])
  end

  def update
    route = Route.find(params[:id])
    route.update(route_params)
    redirect_to "/routes/#{route.id}"
  end

  def destroy
    Route.destroy(params[:id])
    redirect_to "/routes"
  end

  private

  def route_params
    params.permit(:route_name, :sport_route, :trad_route, :pitches, :grade)
  end
end
