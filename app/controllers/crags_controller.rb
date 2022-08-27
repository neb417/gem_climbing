class CragsController < ApplicationController
  def index
    @crags = Crag.order(created_at: :desc)
  end

  def show
    @crag = Crag.find(params[:id])
  end

  def new
  end

  def create
    crag = Crag.create!(crag_params)
    redirect_to '/crags'
  end

  def edit
    @crag = Crag.find(params[:id])
  end

  def update
    crag = Crag.find(params[:id])
    crag.update(crag_params)
    
    redirect_to "/crags/#{crag.id}"
  end

  def crag_params
    params.permit(:crag_name, :reservation_required, :elevation)
  end
end
