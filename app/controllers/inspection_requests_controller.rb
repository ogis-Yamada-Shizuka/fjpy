class InspectionRequestsController < ApplicationController
  before_action :set_inspection_request, only: [:show, :edit, :update, :destroy]

  # GET /inspection_requests
  # GET /inspection_requests.json
  def index
    @inspection_requests = InspectionRequest.all
  end

  # GET /inspection_requests/1
  # GET /inspection_requests/1.json
  def show
  end

  # GET /inspection_requests/new
  def new
    @inspection_request = InspectionRequest.new
  end

  # GET /inspection_requests/1/edit
  def edit
  end

  # POST /inspection_requests
  # POST /inspection_requests.json
  def create
    @inspection_request = InspectionRequest.new(inspection_request_params)

    respond_to do |format|
      if @inspection_request.save
        format.html { redirect_to @inspection_request, notice: 'Inspect request was successfully created.' }
        format.json { render :show, status: :created, location: @inspection_request }
      else
        format.html { render :new }
        format.json { render json: @inspection_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspection_requests/1
  # PATCH/PUT /inspection_requests/1.json
  def update
    respond_to do |format|
      if @inspection_request.update(inspection_request_params)
        format.html { redirect_to @inspection_request, notice: 'Inspect request was successfully updated.' }
        format.json { render :show, status: :ok, location: @inspection_request }
      else
        format.html { render :edit }
        format.json { render json: @inspection_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspection_requests/1
  # DELETE /inspection_requests/1.json
  def destroy
    @inspection_request.destroy
    respond_to do |format|
      format.html { redirect_to inspection_requests_url, notice: 'Inspect request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection_request
      @inspection_request = InspectionRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_request_params
      params.require(:inspection_request).permit(:service_id, :inspect_schedule_id, :schedule)
    end
end
