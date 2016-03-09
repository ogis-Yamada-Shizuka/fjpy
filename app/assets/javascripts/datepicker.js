$(document).ready(function(){
  $(".date.datepicker").datepicker({
    format: 'yyyy年mm月dd日',
    language: 'ja'
  });

  $(".month.datepicker").datepicker({
    format: 'yyyy年mm月',
    language: 'ja',
    minViewMode : 'months'
  });

  $(".datetime.datetimepicker").datetimepicker({
    locale: 'ja',
    ignoreReadonly: true,
    format: 'YYYY年MM月DD日 HH時',
    dayViewHeaderFormat: 'YYYY年 MM月'
  });
});
