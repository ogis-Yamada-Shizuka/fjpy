
crumb :inspection_do_inspection do
  link t('views.inspection_schedule.do_inspecrion'), nil
  parent :daily_work
end

crumb :inspection_schedule_edit do
  link t('views.inspection_schedule.edit'), nil
  parent :daily_work
end

crumb :inspection_schedule_index do
  link t('views.inspection_schedule.requested_soon_index'), nil
  parent :daily_work
end

crumb :inspection_schedule_new do
  link t('views.inspection_schedule.new'), nil
  parent :daily_work
end

crumb :inspection_schedule_show do
  link t('views.inspection_schedule.show'), nil
  parent :daily_work
end
