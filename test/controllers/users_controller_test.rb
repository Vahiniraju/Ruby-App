require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create :user
  end
  test "should get new" do
    log_in_as(@user)
    get user_selections_path
    assert_response :success
  end

end
