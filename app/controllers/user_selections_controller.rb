class UserSelectionsController < ApplicationController
  before_action :logged_in_user, only: [:new,:create]

  def new
    @user_selection = UserSelection.new user: current_user
    user_answered_question_ids = UserSelection.where(user_id: current_user).collect(&:question_id)
    user_created_question_ids = Question.where(user_id: current_user).collect(&:id)
    @user_selection.question = Question.where.not(id: user_answered_question_ids + user_created_question_ids).sample

  end

  def create
    @user_selection = current_user.user_selections.build create_params
    if @user_selection.save
      if @user_selection.correct_answer
        flash[:success] = "You answered correctly."
      else
        flash[:danger] = "Sorry. You got the wrong answer. The correct answer is #{@user_selection.question.correct_answer.title}"
      end
        redirect_to user_selections_path
    else
        flash.now[:danger] = "Please select the answer"
        render 'new'
    end
  end

  private

  def create_params
    params.require(:user_selection).permit(:question_id, :answer_id)
  end


  def logged_in_user
    unless logged_in?
      remember_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
end
