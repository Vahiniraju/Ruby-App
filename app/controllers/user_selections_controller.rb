class UserSelectionsController < ApplicationController
  include UserSelectionsHelper
  before_action :logged_in_user, only: [:new,:create]

  def new
    @user_selection = question_for_user
  end

  def select_category
    @categories = ActsAsTaggableOn::Tag.all.collect(&:name)
  end

  def create
    @user_selection = current_user.user_selections.build create_params
    if @user_selection.save
      if @user_selection.correct_answer
        current_user.score += 4
        flash[:success] = "You answered correctly and score is #{current_user.score}"
      else
        current_user.score -= 1 if current_user.score > 0
        flash[:danger] = "Sorry. You got the wrong answer. The correct answer is #{@user_selection.question.correct_answer.title} and your score is #{current_user.score}"
      end
      if ! (current_user.update_attributes score: current_user.score)
        flash[:danger] = "something went wrong"
      end
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
