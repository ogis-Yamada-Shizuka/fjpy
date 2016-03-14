module InspectionScheduleHelper
  # 見出し
  def render_index_title
    case params[:action]
      when 'need_request' then t('views.inspection_schedule.need_request_index')
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

  def action_link(inspection_schedule)
    fa_pencil = content_tag(:i, '', class: "fa fa-pencil fa-fw")

    # 点検依頼
    if inspection_schedule.can_inspection_request?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.inspection_request'), inspection_request_path(inspection_schedule)

    # 候補日時回答
    elsif inspection_schedule.can_answer_date?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.answer_date'), answer_date_path(inspection_schedule)

    # 日程確定
    elsif inspection_schedule.can_confirm_date?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.confirm_date'), confirm_date_path(inspection_schedule)

    # 点検実施
    elsif inspection_schedule.can_inspection?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.do_inspecrion'), do_inspection_path(inspection_schedule)

    # 承認(作業終了)
    elsif inspection_schedule.can_approval?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.done_inspection'), done_inspection_path(inspection_schedule)

    # 点検の完了
    elsif inspection_schedule.can_close_inspection?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.close_inspecrion'), close_inspection_path(inspection_schedule)
    end
  end

  def fa_pencil_link_to(name, path)
    link_to(path) do
      content_tag(:i, '', class: "fa fa-pencil fa-fw") + name
    end
  end

  def month_field(f, attribute)
    (text_field_for_date(f, attribute, month_or_date: :month) + clear_link(attribute)).html_safe
  end

  def date_field(f, attribute)
    (text_field_for_date(f, attribute) + clear_link(attribute)).html_safe
  end

  def datetime_field(f, attribute)
    (text_field_for_date(f, attribute, month_or_date: :datetime , pick: :datetimepicker ) + clear_link(attribute)).html_safe
  end

  def text_field_for_date(f, attribute, month_or_date: 'date', pick: 'datepicker')
    f.text_field(
      attribute,
      class: "#{month_or_date} #{pick}",
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

  def datetime_value(date)
    date.strftime("%Y年%m月%d日 %HH時") if date.present?
  end

  # 年月
  def show_target_yearmonth?
    permit_action?(%i(index need_request requested_soon date_answered)) &&
    permit_company?(%i(head branch service))
  end

  # 点検予定日時(作業確定日時)
  def show_confirm_datetime?
    permit_action?(%i(index target done)) &&
    permit_company?(%i(head branch service))
  end

  # 型式
  def show_system_model?
    permit_action?(%i(index need_request requested_soon date_answered target done)) &&
    permit_company?(%i(head branch service))
  end

  # シリアルNo.
  def show_serial_number?
    permit_action?(%i(index need_request requested_soon date_answered target done)) &&
    permit_company?(%i(head branch service))
  end

  # 設置場所
  def show_place?
    permit_action?(%i(index need_request requested_soon date_answered target done)) &&
    permit_company?(%i(head branch service))
  end

  # 担当サービス会社
  def show_service?
    permit_action?(%i(index requested_soon date_answered target done)) &&
    permit_company?(%i(head branch))
  end

  # 候補日時1から3
  def show_candidate_datetime?
    permit_action?(%i(date_answered)) &&
    permit_company?(%i(head branch service))
  end

  # アポ担当者(YES拠点)
  def show_author?
    permit_action?(%i(target)) &&
    permit_company?(%i(head branch service))
  end

  # アポ担当者(顧客)
  def show_customer?
    permit_action?(%i(target)) &&
    permit_company?(%i(head branch service))
  end

  # 進捗状況
  def show_schedule_status?
    permit_action?(%i(index)) &&
    permit_company?(%i(head branch service))
  end

  # 進捗させる系
  def show_action?
    case params[:action].to_sym
      when :index then false
      when :need_request then true
      when :requested_soon then true
      when :date_answered then true
      when :target then current_user.branch_employee? ? false : true
      when :done then true
      else false
    end
  end

  # 更新
  def show_edit?
    return true if current_user.head_employee?
    case params[:action].to_sym
      when :index then false
      when :need_request then true
      when :requested_soon then current_user.branch_employee? ? true : false
      when :date_answered then current_user.branch_employee? ? true : false
      when :target then current_user.branch_employee? ? false : true
      when :done then false
      else false
    end
  end

  def permit_action?(actions)
    actions.include?(params[:action].to_sym)
  end

  def permit_company?(companies)
    if current_user.head_employee?
      return true if companies.include?(:head)
    elsif current_user.branch_employee?
      return true if companies.include?(:branch)
    elsif current_user.service_employee?
      return true if companies.include?(:service)
    end
    false
  end
end
