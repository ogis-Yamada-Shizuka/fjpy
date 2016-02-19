module ApplicationHelper
  include Common

  # 点検依頼一覧(直近のみ)
  def requested_inspection_schedules_path
    inspection_schedules_path + "/?q[schedule_status_id_eq]=#{ScheduleStatus.of_requested}&" + latest_parameter
  end

  # 候補日回答済一覧
  def date_answered_inspection_schedules_path
    inspection_schedules_path + "/?q[schedule_status_id_eq]=#{ScheduleStatus.of_date_answered}"
  end

  # 点検作業対象一覧
  def target_inspection_schedules_path
    inspection_schedules_path + schedule_status_id_in(ScheduleStatus.inspection_target_ids)
  end

  # 点検作業完了一覧
  def done_inspection_schedules_path
    inspection_schedules_path + schedule_status_id_in(ScheduleStatus.done_ids)
  end

  # 進捗状況の配列パラメーター
  def schedule_status_id_in(ids)
    '/?' + ids.map { |id| "q[schedule_status_id_in][]=#{id}" }.join('&')
  end

  # 直近(2ヶ月後以前)
  def latest_parameter
    "q[target_yearmonth_date_lteq]=#{Date.parse(current_date) >> 2}"
  end

  # 点検予定一覧画面に進捗状況のクエリパラメーターを与えたパスを生成

  Constants::ScheduleStatus.constants.each do |id|
    schedule_status_name = id.to_s.sub(/ID_/, '').downcase
    define_method "inspection_schedules_path_of_#{schedule_status_name}" do
      inspection_schedules_path + "/?[schedule_status_id_eq]=#{ScheduleStatus.send("of_#{schedule_status_name}")}"
    end
  end
end
