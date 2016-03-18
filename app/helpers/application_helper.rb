module ApplicationHelper
  def admin?
    current_user.admin?
  end

  def show_item_title(title_string)
    ( '<strong>' + title_string + ':</strong>' ).html_safe
  end
end
