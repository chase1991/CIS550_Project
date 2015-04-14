class FoodClassesController < ApplicationController
  before_action :set_food_class, only: [:show, :edit, :update, :destroy]

  # GET /food_classes
  # GET /food_classes.json
  def index
    @food_classes = FoodClass.all
  end

  # GET /food_classes/1
  # GET /food_classes/1.json
  def show
  end

  # GET /food_classes/new
  def new
    @food_class = FoodClass.new
  end

  # GET /food_classes/1/edit
  def edit
  end

  # POST /food_classes
  # POST /food_classes.json
  def create
    @food_class = FoodClass.new(food_class_params)

    respond_to do |format|
      if @food_class.save
        format.html { redirect_to @food_class, notice: 'Food class was successfully created.' }
        format.json { render :show, status: :created, location: @food_class }
      else
        format.html { render :new }
        format.json { render json: @food_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_classes/1
  # PATCH/PUT /food_classes/1.json
  def update
    respond_to do |format|
      if @food_class.update(food_class_params)
        format.html { redirect_to @food_class, notice: 'Food class was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_class }
      else
        format.html { render :edit }
        format.json { render json: @food_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_classes/1
  # DELETE /food_classes/1.json
  def destroy
    @food_class.destroy
    respond_to do |format|
      format.html { redirect_to food_classes_url, notice: 'Food class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_class
      @food_class = FoodClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_class_params
      params.require(:food_class).permit(:name)
    end
end
