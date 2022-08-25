class CragsController < ApplicationController
  def index
    @crags = Crag.all.order(created_at: :desc)
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