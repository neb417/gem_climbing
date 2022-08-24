class CragsController < ApplicationController
  def index
    @crags = Crag.all
  end

  def show
    @crag = Crag.find(params[:id])
  end

  # def new
  # end
  
  # def create
    # crag = Crag.create({
    #   id: params[:id]
    #   name: params[:crag][:name]
    # })
  # end
end