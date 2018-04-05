module ApplicationHelper
  include SessionsHelper

  def render_flash
    render 'shared/flash'
  end

  def render_flash_js
    ("$('#flash_area').replaceWith(\"" + escape_javascript(render_flash) + "\");").html_safe
  end

end
