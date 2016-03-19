module Constants
  # 直近
  LATEST_MONTH = 2

  module ScheduleStatus
    ID_NEED_REQUEST    = 1 # 要点検依頼
    ID_REQUESTED       = 2 # 点検依頼済み
    ID_DATE_ANSWERED   = 3 # 候補日回答済み
    ID_DATES_CONFIRMED = 4 # 日程確認済み
    ID_IN_PROGRESS     = 5 # 点検実施中
    ID_APPROVED        = 6 # 顧客承認済み
    ID_COMPLETED       = 7 # 完了
    ID_NG              = 8 # NG
  end
end
