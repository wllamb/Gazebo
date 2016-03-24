class NeighborhoodsController < ApplicationController
  before_action only: [:show, :edit, :create, :destroy]
  def new
    @neighborhood = Neighborhood.new
    @neighborhoods = Neighborhood.all
  end
  def index
    @neighborhoods = Neighborhood.all
  end
  def create
    @neighborhood = Neighborhood.new(hood_params)
    respond_to do |format|
      if @neighborhood.save
        format.html { redirect_to root_path, notice: "Neighborhood: #{@neighborhood.name} was successfully created." }
        format.json { render :show, status: :created, location: @neighborhood }
      else
        format.html { redirect_to "/neighborhoods/new", notice: "Duplicate neighborhood, try again!" }
        format.json { render json: @neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def hood_params
    params.require(:neighborhood).permit(:name,:zip)
  end
end