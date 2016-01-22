class InspectionParam
  attr_reader :targetyearmonth, :worker_id, :targets

  def initialize(params = {})
    @worker_id = params[:data][:worker]
    @targetyearmonth = params[:when][:year] + params[:when][:month]
    @targets = (params[:check].select { |key, val| val == "1" }).keys
  end
end
