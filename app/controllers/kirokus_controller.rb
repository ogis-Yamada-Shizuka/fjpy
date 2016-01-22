class KirokusController < ApplicationController
  before_action :set_kiroku, only: [:show, :edit, :update, :destroy]

  # GET /kirokus
  # GET /kirokus.json
  def index
    @kirokus = Kiroku.all
  end

  # GET /kirokus/1
  # GET /kirokus/1.json
  def show
    @marker = Gmaps4rails.build_markers(@kiroku) do |kiroku, marker|
      marker.lat kiroku.latitude
      marker.lng kiroku.longitude
      marker.infowindow kiroku.updated_at.to_s
      marker.json({title: kiroku.worker_id.to_s})
    end
  end

  # GET /kirokus/new
  def new
    @kiroku = Kiroku.new
  end

  # GET /kirokus/1/edit
  def edit
  end

  # POST /kirokus
  # POST /kirokus.json
  def create
    @kiroku = Kiroku.new(kiroku_params)
    inspection = Inspection.find(params[:kiroku][:inspection_id])
    inspection.start_inspection  # 点検開始
    inspection.judging(@kiroku)  # 点検結果を判断

    respond_to do |format|
      if @kiroku.save && inspection.save
        format.html { redirect_to @kiroku, notice: 'Kiroku was successfully created.' }
        format.json { render :show, status: :created, location: @kiroku }
      else
        format.html { render :new }
        format.json { render json: @kiroku.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kirokus/1
  # PATCH/PUT /kirokus/1.json
  def update
    respond_to do |format|
      if @kiroku.update(kiroku_params)
        format.html { redirect_to @kiroku, notice: 'Kiroku was successfully updated.' }
        format.json { render :show, status: :ok, location: @kiroku }
      else
        format.html { render :edit }
        format.json { render json: @kiroku.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kirokus/1
  # DELETE /kirokus/1.json
  def destroy
    @kiroku.destroy
    respond_to do |format|
      format.html { redirect_to kirokus_url, notice: 'Kiroku was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kiroku
      @kiroku = Kiroku.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kiroku_params
      params.require(:kiroku).permit(
        :inspection_id, :worker_id, :latitude, :longitude,
        measurement_attributes: [:id, :kiroku_id, :metercount, :testervalue, :point],
        check_attributes: [:id, :kiroku_id, :weather_id, :exterior_id, :tone_id, :stain_id],
        note_attributes: [:id, :kiroku_id, :memo, :picture] )
    end
end
