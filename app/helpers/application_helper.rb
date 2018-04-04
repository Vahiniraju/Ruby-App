module ApplicationHelper
  include SessionsHelper

  def render_flash
    render 'shared/flash'
  end

end
