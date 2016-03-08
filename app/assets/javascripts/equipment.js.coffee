$ ->
  $('select#equipment_system_model_id').change ->
    $.ajax
      url: '/equipment/change_system_model'
      type: 'GET'
      data: system_model_id: $(this).val()

  $('input#equipment_inspection_contract').change ->
    change_inspection_contract()

@change_inspection_contract = ->
  $.ajax
    url: '/equipment/change_inspection_contract'
    type: 'GET'
    data: checked: $('input#equipment_inspection_contract').prop('checked')
