require 'test_helper'



class QuestionNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = create :user
    # @answer = create :answer
  end

  test "user cannot create a question if not logged in"do
    post question_path, params: {question: {title: "Who is the prime minister of India", answers_attributes:[{title:"Narendra Modi"},{title:"Rahul Gandi"},{title:"ManmohanSign"}]}}
    assert_redirected_to login_path
    get question_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as @user
    post question_path, params: {question: {title: "Who is the prime minister of India", answers_attributes:[{title:"Narendra Modi"},{title:"Rahul Gandi"},{title:"ManmohanSign"}]}}
  end


  end

