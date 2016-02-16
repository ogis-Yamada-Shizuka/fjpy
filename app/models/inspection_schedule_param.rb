class InspectionScheduleParam
  attr_reader :target_datetime, :user_id, :targets

  def initialize(params = {})
    @user_id = params[:data][:user]
    @target_datetime = params[:when][:year] + params[:when][:month]
    @targets = (params[:check].select { |_key, val| val == "1" }).keys
  end
end
