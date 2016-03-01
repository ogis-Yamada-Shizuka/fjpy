class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /equipment
  # GET /equipment.json
  def index
    respond_to do |format|
      format.html do
        # YES本社：全件
        if current_user.head_employee?
          @equipment = Equipment.all
        end
        # YES拠点：自拠点が管轄しているもののみ
        if current_user.branch_employee?
           @equipment = Equipment.where(branch_id: current_user.company_id)
        end
        # サービス会社の場合：デフォルトの担当として割り当てられているもののみ
        if current_user.service_employee?
           @equipment = Equipment.where(service_id: current_user.company_id)
        end
      end
      format.csv do
        @equipment = Equipment.all
        send_data render_to_string, type: "text/csv; charset=shift_jis"
      end
    end
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
    @next_inspection_schedule = @equipment.next_inspection_schedule
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: "Equipment was successfully created." }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: "Equipment was successfully updated." }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: "Equipment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    Equipment.import(params[:file])
    redirect_to equipment_index_url, notice: "Equipment imported."
  end

  def placed_equipment
    @equipment = Equipment.where(place_id: params[:place_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def equipment_params
    params.require(:equipment).permit(:serial_number, :inspection_cycle_month, :inspection_contract, :start_date, :system_model_id, :place_id, :branch_id, :service_id)
  end
end
