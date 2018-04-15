module UserSelectionsHelper

  def question_for_user
    user_selection = UserSelection.new user: current_user
    user_answered_question_ids = UserSelection.where(user_id: current_user).collect(&:question_id)
    user_created_question_ids = Question.where(user_id: current_user).collect(&:id)
    user_selected_questions_ids = Question.where.not(id: user_answered_question_ids + user_created_question_ids)
    if params[:tag]
      @tag = params[:tag]
      user_selection.question = user_selected_questions_ids.tagged_with(params[:tag]).sample
    else
      user_selection.question = Question.where.not(id: user_answered_question_ids + user_created_question_ids).sample
    end
    user_selection
  end

end