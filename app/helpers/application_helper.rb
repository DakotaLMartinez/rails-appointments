module ApplicationHelper
  def body_class
    " home" if current_page?(root_path)
  end
end
