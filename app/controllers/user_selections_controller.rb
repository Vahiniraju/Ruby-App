class UserSelectionsController < ApplicationController
  before_action :logged_in_user, only: [:new,:create]

  def new
    if params[:tag]
      @user_selection = UserSelection.new user: current_user
      user_answered_question_ids = UserSelection.where(user_id: current_user).collect(&:question_id)
      user_created_question_ids = Question.where(user_id: current_user).collect(&:id)
      user_selected_questions_ids = Question.where.not(id: user_answered_question_ids + user_created_question_ids)
      @user_selection.question = user_selected_questions_ids.tagged_with(params[:tag]).sample
    else
      @user_selection = UserSelection.new user: current_user
      user_answered_question_ids = UserSelection.where(user_id: current_user).collect(&:question_id)
      user_created_question_ids = Question.where(user_id: current_user).collect(&:id)
      @user_selection.question = Question.where.not(id: user_answered_question_ids + user_created_question_ids).sample
    end

  end

  def select_category
    @categories = ActsAsTaggableOn::Tag.all.collect(&:name)
  end

  def create
    @user_selection = current_user.user_selections.build create_params
    @user_selection.save
    if @user_selection.correct_answer
      current_user.score += 4
      flash[:success] = "You answered correctly and score is #{current_user.score}"
    else
      current_user.score -= 1 if current_user.score > 0
      flash[:danger] = "Sorry. You got the wrong answer. The correct answer is #{@user_selection.question.correct_answer.title} and your score is #{current_user.score}"
    end
    current_user.update_attributes score: current_user.score
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
