$ ->
  change_inspection_contract()

  $('select#equipment_system_model_id').change ->
    $.ajax
      url: 'change_system_model'
      type: 'GET'
      data: system_model_id: $(this).val()

  $('input#equipment_inspection_contract').change ->
    change_inspection_contract()

change_inspection_contract = ->
  $.ajax
    url: 'change_inspection_contract'
    type: 'GET'
    data: checked: $('input#equipment_inspection_contract').prop('checked')
