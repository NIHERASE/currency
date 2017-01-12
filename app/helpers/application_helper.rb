module ApplicationHelper
  def navbar_tab_class(tab_controller_name)
    'active' if controller_name == tab_controller_name
  end
end
