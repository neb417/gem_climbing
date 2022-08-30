class CragsController < ApplicationController

  def index
    # @crags = Crag.order(created_at: :desc)
    all_crags = Crag.all
    if params[:order_by_routes]
      @crags = all_crags.route_count
      # binding.pry
    else
      @crags = all_crags.order(created_at: :desc)
    end
  end

  def show
    @crag = Crag.find(params[:id])
  end

  def new
  end

  def create
    crag = Crag.new(crag_params)
    if crag.save
      redirect_to '/crags'
    else
      flash[:notice] = "Crag not created: Required information missing"
      render :new
    end
  end

  def edit
    @crag = Crag.find(params[:id])
  end

  def update
    crag = Crag.find(params[:id])
    crag.update(crag_params)
    redirect_to "/crags/#{crag.id}"
  end

  def destroy
    Crag.destroy(params[:id])
    redirect_to "/crags"
  end

  private

  def crag_params
    params.permit(:crag_name, :reservation_required, :elevation)
  end
end
