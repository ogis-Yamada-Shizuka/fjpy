class SystemModelsController < ApplicationController
  before_action :set_system_model, only: [:show, :edit, :update, :destroy]

  # GET /system_models
  # GET /system_models.json
  def index
    @system_models = SystemModel.all
  end

  # GET /system_models/1
  # GET /system_models/1.json
  def show
  end

  # GET /system_models/new
  def new
    @system_model = SystemModel.new
  end

  # GET /system_models/1/edit
  def edit
  end

  # POST /system_models
  # POST /system_models.json
  def create
    @system_model = SystemModel.new(system_model_params)

    respond_to do |format|
      if @system_model.save
        format.html { redirect_to @system_model, notice: "SystemModel was successfully created." }
        format.json { render :show, status: :created, location: @system_model }
      else
        format.html { render :new }
        format.json { render json: @system_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_models/1
  # PATCH/PUT /system_models/1.json
  def update
    respond_to do |format|
      if @system_model.update(system_model_params)
        format.html { redirect_to @system_model, notice: "SystemModel was successfully updated." }
        format.json { render :show, status: :ok, location: @system_model }
      else
        format.html { render :edit }
        format.json { render json: @system_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_models/1
  # DELETE /system_models/1.json
  def destroy
    @system_model.destroy
    respond_to do |format|
      format.html { redirect_to system_models_url, notice: "SystemModel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_system_model
    @system_model = SystemModel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def system_model_params
    params.require(:system_model).permit(:name, :inspection_cycle_month)
  end
end
