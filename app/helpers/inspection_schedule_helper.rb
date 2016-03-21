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

    f.collection_select(:service_id, Service.all, :id, :name).html_safe
  end

  def action_link(inspection_schedule)
    # 点検依頼
    if inspection_schedule.can_inspection_request?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.inspection_request'), inspection_request_path(inspection_schedule)

    # 候補日時回答
    elsif inspection_schedule.can_answer_date?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.answer_date'), answer_date_path(inspection_schedule)

    # 出張依頼
    elsif inspection_schedule.can_confirm_date?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.confirm_date'), confirm_date_path(inspection_schedule)

    # 点検報告作成
    elsif inspection_schedule.can_inspection?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.do_inspecrion'), do_inspection_path(inspection_schedule)

    # サイン
    elsif inspection_schedule.can_approval?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.done_inspection'), done_inspection_path(inspection_schedule)

    # 承認
    elsif inspection_schedule.can_close_inspection?(current_user)
      fa_pencil_link_to t('views.inspection_schedule.close_inspecrion'), close_inspection_path(inspection_schedule)
    end
  end

  def correct_link(inspection_schedule)
    # 点検依頼可能時　※サービス会社ユーザーは変更不可
    if inspection_schedule.can_inspection_request?(current_user) && !current_user.service_employee?
      fa_refresh_link_to(
        t('views.inspection_schedule.correct_targetyearmonth'),
        correct_targetyearmonth_path(inspection_schedule)
      )

    # 候補日時回答可能時　※サービス会社ユーザーは変更不可
    elsif inspection_schedule.can_answer_date?(current_user) && !current_user.service_employee?
      fa_refresh_link_to t('views.inspection_schedule.inspection_request'), inspection_request_path(inspection_schedule)

    # 日程確定可能時
    elsif inspection_schedule.can_confirm_date?(current_user)
      fa_refresh_link_to t('views.inspection_schedule.answer_date'), answer_date_path(inspection_schedule)

    # 点検実施可能時(日程確定済の場合)
    elsif inspection_schedule.schedule_status_id == ScheduleStatus.of_dates_confirmed && !current_user.service_employee?
      fa_refresh_link_to t('views.inspection_schedule.confirm_date'), confirm_date_path(inspection_schedule)

    # サイン可能時
    elsif inspection_schedule.can_approval?(current_user)
      fa_refresh_link_to t('views.inspection_schedule.do_inspecrion'), do_inspection_path(inspection_schedule)

    # 承認可能時　※変更不可
    elsif inspection_schedule.can_close_inspection?(current_user)
      ''
    end
  end

  def fa_pencil_link_to(name, path)
    link_to(path) do
      content_tag(:i, '', class: 'fa fa-pencil fa-fw') + name
    end
  end

  def fa_newspaper_link_to(name, path)
    link_to(path) do
      content_tag(:i, '', class: 'fa fa-newspaper-o fa-fw') + name
    end
  end

  def fa_refresh_link_to(name, path)
    link_to(path) do
      content_tag(:i, '', class: 'fa fa-refresh fa-fw') + name
    end
  end

  def month_field(f, attribute)
    content_tag(:div, id: :datetimepicker, class: 'input-group month') do
      text_field_for_month(f, attribute)
    end.html_safe
  end

  def datetime_field(f, attribute)
    content_tag(:div, id: :datetimepicker, class: 'input-group datetime') do
      text_field_for_datetime(f, attribute)
    end.html_safe
  end

  def text_field_for_month(f, attribute)
    f.text_field(
      attribute,
      class: 'form-control',
      readonly: true,
      value: @inspection_schedule.send(attribute).try(:strftime, "%Y年%m月")
    ) + glyphicon_calendar
  end

  def text_field_for_datetime(f, attribute)
    f.text_field(
      attribute,
      class: 'form-control',
      readonly: true,
      value: @inspection_schedule.send(attribute).try(:strftime, "%Y年%m月%d日 %p %l時")
    ) + glyphicon_calendar
  end

  def glyphicon_calendar
    content_tag(:span, class: 'input-group-addon') do
      content_tag(:span, '', class: 'glyphicon glyphicon-calendar')
    end
  end

  def clear_link(attribute)
    link_to('クリア', {}, onclick: "$('#inspection_schedule_#{attribute}').val('')", remote: true)
  end

  # 担当
  def show_yes_branch_staff?
    permit_action?(%i(index requested_soon date_answered target done)) &&
      permit_company?(%i(branch))
  end

  # 予定年月
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
    return true if admin?
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

  ################
  # show およびステータス進める系画面への表示用
  ################

  # 予定年月
  def show_target_yearmonth
    show_attribute(
      t('activerecord.attributes.inspection_schedule.target_yearmonth'),
      l(@inspection_schedule.target_yearmonth, format: :target_yearmonth)
    )
  end

  # 点検実施会社
  def show_service
    show_attribute(
      t('activerecord.attributes.inspection_schedule.service_id'),
      @inspection_schedule.service.name
    )
  end

  # ステータス
  def show_schedule_status
    show_attribute(
      t('activerecord.attributes.inspection_schedule.schedule_status_id'),
      @inspection_schedule.schedule_status.name
    )
  end

  # 候補日時１～３
  def show_candidate_datetime1
    show_attribute(
      t('activerecord.attributes.inspection_schedule.candidate_datetime1'),
      l(@inspection_schedule.candidate_datetime1, format: :candidate_long)
    )
  end

  def show_candidate_datetime2
    show_attribute(
      t('activerecord.attributes.inspection_schedule.candidate_datetime2'),
      l(@inspection_schedule.candidate_datetime2, format: :candidate_long)
    )
  end

  def show_candidate_datetime3
    show_attribute(
      t('activerecord.attributes.inspection_schedule.candidate_datetime3'),
      l(@inspection_schedule.candidate_datetime3, format: :candidate_long)
    )
  end

  def show_candidate_datetime_memo
    show_attribute(
      t('activerecord.attributes.inspection_schedule.candidate_datetime_memo'),
      @inspection_schedule.candidate_datetime_memo
    )
  end

  # 確定日時
  def show_confirm_datetime
    show_attribute(
      t('activerecord.attributes.inspection_schedule.confirm_datetime'),
      l(@inspection_schedule.confirm_datetime, format: :confirm_long)
    )
  end

  def show_confirm_datetime_memo
    show_attribute(
      t('activerecord.attributes.inspection_schedule.confirm_datetime_memo'),
      @inspection_schedule.confirm_datetime_memo
    )
  end

  def show_author
    show_attribute(
      t('activerecord.attributes.inspection_schedule.author'),
      @inspection_schedule.author
    )
  end

  def show_customer
    show_attribute(
      t('activerecord.attributes.inspection_schedule.customer'),
      @inspection_schedule.customer
    )
  end

  # 点検依頼者
  def show_yes_branch_staff
    show_attribute(
      t('activerecord.attributes.inspection_schedule.user'),
      (@inspection_schedule.user.name if @inspection_schedule.user.present?)
    )
  end

  # 一覧上の[担当]マーク
  def yes_branch_staff_mark(inspection_schedule)
    if inspection_schedule.user.present? && inspection_schedule.user.id == current_user.id
      return t('views.inspection_schedule.yes_branch_staff_mark')
    else
      return ''
    end
  end
end
