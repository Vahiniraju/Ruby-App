require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create :user
  end
  test "should get new" do
    log_in_as(@user)
    get question_path
    assert_response :success
  end

end
