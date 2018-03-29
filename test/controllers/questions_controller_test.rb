require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get question_path
    assert_response :success
  end

end
