$ ->
  $('select#equipment_system_model_id').change ->
    $.ajax
      url: 'set_inspection_cycle'
      type: 'GET'
      data: system_model_id: $(this).val()
