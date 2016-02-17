module Constants
  module ScheduleStatus
    ID_REQUESTED       = 1 # 点検依頼済み
    ID_DATE_ANSWERED   = 2 # 候補日回答済み
    ID_DATES_CONFIRMED = 3 # 日程確認済み
    ID_IN_PROGRESS     = 4 # 点検実施中
    ID_APPROVED        = 5 # 顧客承認済み
    ID_COMPLETED       = 6 # 完了
    ID_NG              = 7 # NG
  end
end
