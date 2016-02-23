class ScheduleStatusesController < ApplicationController
  before_action :set_schedule_status, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @schedule_statuses = ScheduleStatus.all
    respond_with(@schedule_statuses)
  end

  def show
    respond_with(@schedule_status)
  end

  def new
    @schedule_status = ScheduleStatus.new
    respond_with(@schedule_status)
  end

  def edit
  end

  def create
    @schedule_status = ScheduleStatus.new(schedule_status_params)
    @schedule_status.save
    respond_with(@schedule_status)
  end

  def update
    @schedule_status.update(schedule_status_params)
    respond_with(@schedule_status)
  end

  def destroy
    @schedule_status.destroy
    respond_with(@schedule_status)
  end

  private
    def set_schedule_status
      @schedule_status = ScheduleStatus.find(params[:id])
    end

    def schedule_status_params
      params.require(:schedule_status).permit(:name)
    end
end
