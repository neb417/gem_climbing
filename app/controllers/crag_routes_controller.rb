class CragRoutesController < ApplicationController
  def index
    @crag = Crag.find(params[:id])
    @crag_routes = @crag.routes
  end
end