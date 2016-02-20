module InspectionScheduleHelper
  # 見出し
  def render_index_title
    case params[:action]
      when 'requested_soon' then t('views.inspection_schedule.requested_soon_index')
      when 'date_answered' then t('views.inspection_schedule.answered_index')
      when 'target' then t('views.inspection_schedule.targets_index')
      when 'done' then t('views.inspection_schedule.done_index')
      else t('views.inspection_schedule.index')
    end
  end

  # 担当サービス会社の選択 UI をレンダリングする
  def render_service_select(f)
    # YES 本社なら全サービス会社から選択可能
    if current_user.head_employee?
      return f.collection_select(:service_id, Service.all, :id, :name).html_safe
    end

    # YES 拠点なら管轄のサービス会社から選択可能
    if current_user.branch_employee?
      return f.collection_select(:service_id, current_user.company.services, :id, :name).html_safe
    end

    # サービス会社なら読み込み専用
    if current_user.service_employee?
      return f.select(:service_id, Service.all.map { |t| [t.name, t.id] }, {}, disabled: true).html_safe
    end
  end

  def month_field(f, attribute)
    (text_field_for_date(f, attribute, month_or_date: :month) + clear_link(attribute)).html_safe
  end

  def date_field(f, attribute)
    (text_field_for_date(f, attribute) + clear_link(attribute)).html_safe
  end

  def text_field_for_date(f, attribute, month_or_date: 'date')
    f.text_field(
      attribute,
      class: "#{month_or_date} datepicker",
      readonly: true,
      value: send("#{month_or_date}_value", @inspection_schedule.send(attribute))
    )
  end

  def clear_link(attribute)
    link_to('クリア', {}, onclick: "$('#inspection_schedule_#{attribute}').val('')", remote: true)
  end

  def month_value(date)
    date.strftime("%Y年%m月") if date.present?
  end

  def date_value(date)
    date.strftime("%Y年%m月%d日") if date.present?
  end
end
