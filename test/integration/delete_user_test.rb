require 'test_helper'

class DeleteUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = create :user
  end

  test "only logged in user can delete his profile" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end
end
