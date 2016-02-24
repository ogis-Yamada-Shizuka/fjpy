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
});
