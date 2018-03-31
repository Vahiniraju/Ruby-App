require 'test_helper'

class UserSelectionTest < ActiveSupport::TestCase

  def setup
    @question = create :question
    @question_1 = create :question
    @user = create :user
    @answer_id = @question.answers[0].id
    @answer_id_1 = @question_1.answers.sample.id
    @user_selection = UserSelection.new(user_id: @user.id, question_id: @question.id, answer_id: @answer_id )
  end

  test "user_selection should not have empty user_id" do
    @user_selection.user_id =  ''
    @user_selection.save
    refute @user_selection.valid?
  end


  test "user_selection should not have empty answer_id" do
    @user_selection.answer_id =  ' '
    @user_selection.save
    refute @user_selection.valid?
  end

  test "user_selection valid record" do
    @user_selection.save
    assert @user_selection.valid?
  end

  test "user_seletion answer should belong to the question" do
    @user_selection.answer_id = @answer_id_1
    @user_selection.save
    refute @user_selection.valid?
  end

  test "question answered should not be belong to user" do
    @user_selection.user_id = @question.user_id
    @user_selection.save
    refute @user_selection.valid?
  end

end
