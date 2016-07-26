class Admin::ApproveQuestionsController < ApplicationController
  before_action :authorize_admin!

  def update
    @suggest_question = SuggestQuestion.find_by id: params[:suggest_question_id]
    if @suggest_question.update_attributes approve: params[:approve]
      flash[:success] = t "suggest_questions.updated"
    else
      flash[:danger] = t "suggest_questions.failed"
    end
    redirect_to admin_suggest_questions_path   
  end
end
