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

  def inspection_contract_string
    if @equipment.inspection_contract then
      t('views.equipment.inspection_contract_true')
    else
      t('views.equipment.inspection_contract_false')
    end
  end
end
