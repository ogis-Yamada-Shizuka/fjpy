module ApplicationHelper
  def date_value(date)
    date.strftime("%Y年%m月%d日") if date.present?
  end
end
