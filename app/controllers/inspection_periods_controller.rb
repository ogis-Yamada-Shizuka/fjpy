class InspectionPeriodsController < ApplicationController
  before_action :set_inspection_period, only: [:show, :edit, :update, :destroy]

  # GET /inspection_periods
  # GET /inspection_periods.json
  def index
    @inspection_periods = InspectionPeriod.all
  end

  # GET /inspection_periods/1
  # GET /inspection_periods/1.json
  def show
  end

  # GET /inspection_periods/new
  def new
    @inspection_period = InspectionPeriod.new
  end

  # GET /inspection_periods/1/edit
  def edit
  end

  # POST /inspection_periods
  # POST /inspection_periods.json
  def create
    @inspection_period = InspectionPeriod.new(inspection_period_params)

    respond_to do |format|
      if @inspection_period.save
        format.html { redirect_to @inspection_period, notice: 'Inspection period was successfully created.' }
        format.json { render :show, status: :created, location: @inspection_period }
      else
        format.html { render :new }
        format.json { render json: @inspection_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspection_periods/1
  # PATCH/PUT /inspection_periods/1.json
  def update
    respond_to do |format|
      if @inspection_period.update(inspection_period_params)
        format.html { redirect_to @inspection_period, notice: 'Inspection period was successfully updated.' }
        format.json { render :show, status: :ok, location: @inspection_period }
      else
        format.html { render :edit }
        format.json { render json: @inspection_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspection_periods/1
  # DELETE /inspection_periods/1.json
  def destroy
    @inspection_period.destroy
    respond_to do |format|
      format.html { redirect_to inspection_periods_url, notice: 'Inspection period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection_period
      @inspection_period = InspectionPeriod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_period_params
      params[:inspection_period]
    end
end
