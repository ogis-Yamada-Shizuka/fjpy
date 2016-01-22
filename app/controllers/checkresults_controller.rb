class CheckresultsController < ApplicationController
  before_action :set_checkresult, only: [:show, :edit, :update, :destroy]

  # GET /checkresults
  # GET /checkresults.json
  def index
    @checkresults = Checkresult.all
  end

  # GET /checkresults/1
  # GET /checkresults/1.json
  def show
  end

  # GET /checkresults/new
  def new
    @checkresult = Checkresult.new
  end

  # GET /checkresults/1/edit
  def edit
  end

  # POST /checkresults
  # POST /checkresults.json
  def create
    @checkresult = Checkresult.new(checkresult_params)

    respond_to do |format|
      if @checkresult.save
        format.html { redirect_to @checkresult, notice: 'Checkresult was successfully created.' }
        format.json { render :show, status: :created, location: @checkresult }
      else
        format.html { render :new }
        format.json { render json: @checkresult.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkresults/1
  # PATCH/PUT /checkresults/1.json
  def update
    respond_to do |format|
      if @checkresult.update(checkresult_params)
        format.html { redirect_to @checkresult, notice: 'Checkresult was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkresult }
      else
        format.html { render :edit }
        format.json { render json: @checkresult.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkresults/1
  # DELETE /checkresults/1.json
  def destroy
    @checkresult.destroy
    respond_to do |format|
      format.html { redirect_to checkresults_url, notice: 'Checkresult was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkresult
      @checkresult = Checkresult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkresult_params
      params.require(:checkresult).permit(:name)
    end
end
