module EquipmentHelper
  # 管轄(YES 拠点)の選択 UI をレンダリングする
  def render_branch_select(f)
    # YES 本社なら全サービス会社から選択可能
    if current_user.head_employee?
      return f.collection_select(:branch_id, Branch.all, :id, :name).html_safe
    end

    # YES 拠点、サービス会社なら読み込み専用
    disable_branch_select(f)
  end

  # new_record なら自身の拠点を選択
  def disable_branch_select(f)
    (f.hidden_field(:branch_id, value: selected_branch_id) +
      f.select(
        :branch_id,
        options_for_select(Branch.all.map { |t| [t.name, t.id] }, selected_branch_id),
        {},
        disabled: true
      )
    ).html_safe
  end

  def selected_branch_id
    @equipment.new_record? ? current_user.branch.id : @equipment.branch_id
  end

  def inspection_contract_string(equipment = nil)
      t("views.equipment.inspection_contract_#{(equipment || @equipment).inspection_contract ? 'true' : 'false'}")
  end

  def show_system_model(equipment = nil)
    ( '<p>' +
      show_item_title( t('activerecord.attributes.equipment.system_model_id') ) +
      (equipment || @equipment).system_model.name +
      '</p>' ).html_safe
  end

  def show_serial_number(equipment = nil)
    ( '<p>'+
      show_item_title( t('activerecord.attributes.equipment.serial_number') ) +
      (equipment || @equipment).serial_number +
      '</p>'  ).html_safe
  end

  def show_start_date(equipment = nil)
    ( '<p>'+
      show_item_title( t('activerecord.attributes.equipment.start_date') ) +
      l((equipment || @equipment).start_date, format: :start_date) +
      '</p>'  ).html_safe
  end


  def show_place(equipment = nil)
    ( '<p>' +
      show_item_title( t('activerecord.attributes.equipment.place_id') ) +
      (equipment || @equipment).place.name +
      '</p>' ).html_safe
  end

  def show_inspection_cycle_month(equipment = nil)
    ( '<p>' +
      show_item_title( t('activerecord.attributes.equipment.inspection_cycle_month') ) +
      (equipment || @equipment).inspection_cycle_month.to_s +
      '</p>' ).html_safe
  end

end
