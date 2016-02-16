class Equipment < ActiveRecord::Base
  belongs_to :system_model
  belongs_to :place
  belongs_to :branch
  belongs_to :service

  has_many :inspection_schedules

  # CSV Upload
  require "csv"
  def self.import(file)
    CSV.foreach(file.path, encoding: "SJIS:UTF-8", headers: true) do |row|
      model = find_by_id(row["id"]) || new
      model.attributes = row.to_hash.slice(*column_names)
      model.save!
    end
  end

  def self.no_inspection_list
    equipment_list = InspectionSchedule.old_inspection_equipment_list

    Equipment.includes(:inspection_schedules)
             .references(:inspection_schedules)
             .where(InspectionSchedule.arel_table[:equipment_id].eq(nil)
             .or(InspectionSchedule.arel_table[:equipment_id].in(equipment_list)))
  end

  # 渡された年月が自分の点検年月にあたるかを Yes/No で回答する
  def is_inspection_datetime(target_year, target_month)

    res = true # 戻り値を設定。点検予定が１つも無いときは true で抜けるよ。

    # 点検予定の最未来のものを取る(１件だけ)
    inspection_schedules = self.inspection_schedules.order(target_yearmonth: :desc).limit(1)

    inspection_schedules.each do | last_inspection_schedule |
      # 最未来の点検予定の年月を年と月に分割
      last_ym = last_inspection_schedule.target_yearmonth.scan(/.{1,#{4}}/)

      # 型式の点検周期(月)を年と月に分割
      inc_year  = self.system_model.inspection_cycle_month/12
      inc_month = self.system_model.inspection_cycle_month%12

      # 最未来の点検予定から起算した次回の点検年と月を計算
      next_y = last_ym[0].to_i+inc_year
      next_m = last_ym[1].to_i+inc_month

      if target_year.to_i==next_y and target_month.to_i==next_m
        res = true # 一致の時
      else
        res = false
      end
    end

    return res
  end

  # 渡された年月の点検予定が存在するかを Yes/No で回答する
  def exist_inspection(target_year, target_month)
    if InspectionSchedule.where(equipment_id: self.id, target_yearmonth: target_year+target_month).count == 0
      return false # ない
    else
      return true # ある
    end
  end

end