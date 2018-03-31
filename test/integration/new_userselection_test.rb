require 'test_helper'

class NewUserselectionTest < ActionDispatch::IntegrationTest
  def setup
      @user = create :user
      @question = create :question
      @user_selection = { user_selection: {user_id: @user.id,question_id: @question.id, answer_id: @question.answers.sample.id }}
      @user_selection1 = { user_selection: {user_id: @question.user_id,question_id: @question.id, answer_id: @question.answers.sample.id }}
  end

  test "only login user can get to answer the question" do
    get user_selections_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    post user_selections_path, params: @user_selection
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as(@user)
    get user_selections_path
    assert_template 'user_selections/new'
    post user_selections_path , params: @user_selection
    assert_redirected_to @user_selection_path
    follow_redirect!
    assert_template 'user_selections/new'
    refute flash.empty?
    post user_selections_path , params: @user_selection1
    refute flash.empty?
    assert_template 'user_selections/new'
  end

end
