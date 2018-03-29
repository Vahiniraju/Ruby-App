require 'test_helper'

class DeactivateUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = create :user
  end

  test "only logged in user can deactivate his profile" do
    get deactivate_user_path(@user)
    assert_redirected_to login_path
    log_in_as(@user)
    get deactivate_user_path(@user)
  end
end
