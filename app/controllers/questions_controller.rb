class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:new,:create]
  def new
    @question = Question.new
    3.times { @question.answers.build  }
    @question.answers.first.is_correct = true
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.answers[0].is_correct = true
    @question.answers[1].is_correct = false
    @question.answers[2].is_correct = false
    if @question.save
      flash[:success] = "You have successfully created a Question. Want to create another?"
      redirect_to question_path
    else
      render 'new'
    end
  end


  private

  def question_params
    params.require(:question).permit(:title,:tag_list, answers_attributes:[:title])
  end

  def logged_in_user
    unless logged_in?
      remember_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
end
