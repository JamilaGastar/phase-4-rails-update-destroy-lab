class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants, except: [:created_at, :updated_at]
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant, except: [:created_at, :updated_at]
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, except: [:created_at, :updated_at], status: :created
  end

  # PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, except: [:created_at, :updated_at]
    
  end

  # DESTROY /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def find_plant
    Plant.find(params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def render_not_found_response
    render json: { error: "Plant not found" }, status: :not_found
  end

end
