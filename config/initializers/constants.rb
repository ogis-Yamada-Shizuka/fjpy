module Constants
  module Status
    ID_UNALLOCATED   = 1 # 担当未割当
    ID_READY         = 2 # 実施待ち
    ID_DOING         = 3 # 実施中
    ID_DONE          = 4 # 完了
  end

  module Result
    ID_OK            = 1 # 合格
    ID_NG            = 2 # 不合格
    ID_UNKNOWN       = 3 # 状態不明
    ID_PREINITIATION = 4 # 検査前
  end

end
