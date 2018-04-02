require 'test_helper'



class QuestionNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = create :user
    @question = {question: {title: "Who is the prime minister of India", answers_attributes:[{title:"Narendra Modi"},{title:"Rahul Gandi"},{title:"ManmohanSign"}]}}
    @question1 = {question: {title: "Who is the prime minister of India", answers_attributes:[{title:""},{title:"Rahul Gandi"},{title:"ManmohanSign"}]}}

  end

  test "user cannot create a question if not logged in"do
    get question_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    post question_path, params: @question
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as @user
    get question_path
    assert_template 'questions/new'
    post question_path , params: @question
    refute flash.empty?
    assert_redirected_to question_path
    follow_redirect!
    assert_template 'questions/new'
    post question_path , params: @question1
    assert_template 'questions/new'
  end

end

