module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    notice: 'alert-info',
    alert: 'alert-warning',
    error: 'alert-danger',
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: "alert") do
        concat(content_tag(:button, '', type: "button", class: "close", data: { dismiss: 'alert' }, aria: {label: 'Close'}) do
          concat content_tag(:span, '×', aria: {hidden: true})
        end)
        concat message
      end)
    end
    nil
  end
end
