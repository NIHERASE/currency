module ApplicationHelper
  def navbar_tab_class(tab_controller_name)
    'active' if controller_name == tab_controller_name
  end

  def alert_class_for(flash_type)
    {
      success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end
