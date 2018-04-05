require 'test_helper'

class DeactivateUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = create :user
  end

  test "only logged in user can deactivate his profile" do
    get deactivate_user_path(@user)
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as(@user)
    assert_difference "User.where(active: true).count", -1 do
      get deactivate_user_path(@user)
    end
  end
end
