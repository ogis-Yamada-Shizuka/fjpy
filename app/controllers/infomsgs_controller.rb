class InfomsgsController < ApplicationController
  before_action :set_infomsg, only: [:show, :edit, :update, :destroy]

  # GET /infomsgs
  # GET /infomsgs.json
  def index
    @infomsgs = Infomsg.all.order('effective_date DESC')
  end

  # GET /infomsgs/1
  # GET /infomsgs/1.json
  def show
  end

  # GET /infomsgs/new
  def new
    @infomsg = Infomsg.new
  end

  # GET /infomsgs/1/edit
  def edit
  end

  # POST /infomsgs
  # POST /infomsgs.json
  def create
    @infomsg = Infomsg.new(infomsg_params)

    respond_to do |format|
      if admin?(params[:check][:adminpass]) && @infomsg.save
        format.html { redirect_to @infomsg, notice: 'Infomsg was successfully created.' }
        format.json { render :show, status: :created, location: @infomsg }
      else
        format.html { render :new }
        format.json { render json: @infomsg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infomsgs/1
  # PATCH/PUT /infomsgs/1.json
  def update
    @infomsg.assign_attributes(infomsg_params)  # password error で入力値がクリアされないよう先にセットしておく

    respond_to do |format|
      if admin?(params[:check][:adminpass]) && @infomsg.update(infomsg_params)
        format.html { redirect_to @infomsg, notice: 'Infomsg was successfully updated.' }
        format.json { render :show, status: :ok, location: @infomsg }
      else
        format.html { render :edit }
        format.json { render json: @infomsg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infomsgs/1
  # DELETE /infomsgs/1.json
  def destroy
    @infomsg.destroy
    respond_to do |format|
      format.html { redirect_to infomsgs_url, notice: 'Infomsg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deleteByAdmin
    @infomsg = Infomsg.find(params[:id][:trg])
    respond_to do |format|
      if admin?(params[:check][:adminpass]) && @infomsg.destroy
        format.html { redirect_to infomsgs_url, notice: 'Infomsg was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :show }
        format.json { render json: @infomsg.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  
    def admin?(pass)
      if pass == Rails.application.secrets.infomsg_admn_pass
        admin = true
      else
        @infomsg.errors[:base] << 'パスワードが違います。'
        admin = false
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_infomsg
      @infomsg = Infomsg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infomsg_params
      params.require(:infomsg).permit(:effective_date, :title, :description)
    end
end
