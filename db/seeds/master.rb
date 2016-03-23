ScheduleStatus.delete_all_with_reset_pk_sequence
%w(要点検依頼 点検依頼済 候補日回答済 出張依頼済 点検報告作成済 サイン済 承認済 NG).each do |name|
  ScheduleStatus.create(name: name)
end

Weather.delete_all_with_reset_pk_sequence
%w(晴 曇 雨 雪).each do |name|
  Weather.create(name: name)
end

Checkresult.delete_all_with_reset_pk_sequence
%w(優 良 可 不可).each do |name|
  Checkresult.create(name: name)
end

Flag.delete_all_with_reset_pk_sequence
%w(Open Close).each do |name|
  Flag.create(name: name)
end
