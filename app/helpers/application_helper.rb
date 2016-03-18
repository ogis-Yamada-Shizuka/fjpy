module ApplicationHelper
  def admin?
    current_user.admin?
  end

  def show_attribute(title, value)
    "<p><strong>#{title}: </strong>#{value}</p>".html_safe
  end
end
