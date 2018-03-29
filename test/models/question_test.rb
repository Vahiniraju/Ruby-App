require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    @question = create :question
  end

  test "Question title cannot be blank" do
    @question.title = " "
    @question.save
    refute @question.valid?
  end

  test "Question should have 3 answers" do
    @question.answers.build(title: "foo#4", is_correct:false)
    @question.save
    refute @question.valid?
  end


  test "Question should have only one correct answer" do
    @question.answers[1].is_correct = true
    refute @question.valid?
  end

  test "valid question save" do
    @question.save
    assert @question.valid?
  end

  test "answer title should not be blank" do
    @question.answers[0].title = " "
    @question.save
    refute @question.valid?
  end

  test "user_id should be present " do
    @question.user_id = " "
    @question.save
    refute @question.valid?
  end

  test "user_id should be existing" do
   @question.user_id = User.last.id + 1
    @question.save
    refute @question.valid?
  end


end
