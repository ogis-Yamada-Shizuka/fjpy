module ApplicationHelper
  def admin?
    current_user.admin?
  end

  def show_attribute(title, value)
    "<p><strong>#{title}: </strong>#{value}</p>".html_safe
  end

  def datetimepicker_wrapper(&block)
    content_tag(:div, class: :row) do
      content_tag(:div, class: 'field col-sm-3') do
        content_tag(:div, id: :datetimepicker) do
          capture(&block)
        end
      end
    end
  end
end
