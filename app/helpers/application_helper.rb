module ApplicationHelper
  def sanitize_partial(html)
    html.gsub("\"", "'").gsub("\n", "").strip if html
  end

  def select_for_controller(controller_name, action_name)
   return 'selected' if controller_name.to_sym == controller.params[:controller].to_sym and action_name.to_sym == controller.params[:action].to_sym
  end

  def current_menu_title
    I18n.translate ".#{controller.params[:controller]}.#{controller.params[:action]}.menu_name"
  end

  def show_current_menu
    controller.params[:action] == "edit" || controller.params[:action] == "new"
  end
end
