class SuggestQuestionsController < ApplicationController 
  before_action :load_params, only: [:new, :create]
  load_and_authorize_resource
  
  def index
    @suggest_questions = @suggest_questions.by_user current_user
  end
  
  def new
    @suggest_question.suggest_answers.build
  end
  
  def create
    if @suggest_question.save
      flash[:success] = t "suggest_questions.created"
    else
      render :new
    end
    redirect_to suggest_questions_path
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :question, :question_type, :user_id,
      :subject_id, answers_attributes: [:id, :answer, :is_correct, :_destroy]
  end

  def load_params
    @subjects = Subject.all
    @question_types = Question.question_types
  end
end
