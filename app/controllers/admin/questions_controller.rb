class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index
  
  before_action :load_params, only: [:new]

  def index
    @search = Question.search params[:q]
    @questions = @search.result.page(params[:page]).per Settings.per_page
    @search.build_condition
  end
  
  def new
    @question.answers.build
  end

  def create
    if @question.save
      flash[:success] = t "question.create_succ"
      redirect_to admin_questions_path
    else
      load_params
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :question, :question_type,
      :subject_id, answers_attributes: [:id, :answer, :is_correct, :_destroy]
  end

  def load_params
    @subjects = Subject.all
    @question_types = Question.question_types
  end
end
