$(document).ready(function(){
  $("#datetimepicker .month").datetimepicker({
    ignoreReadonly: true,
    format: 'YYYY年MM月'
  });

  $("#datetimepicker .datetime").datetimepicker({
    ignoreReadonly: true,
    format: 'YYYY年MM月DD日 A hh時'
  });
});
