class Admin::ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:index, :edit]
  before_action :update_state_result, only: :edit

  def index
    @exams = Exam.all.includes :subject
  end

  def edit
  end

  def update
    if @exam.update_attributes exam_params
      update_score()
      flash[:success] = t "exam.update.success"
    else
      flash[:danger] = t "exam.update.error"
    end
    @exam.create_activity key: "exam.update", recipient: @exam.user
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :status, :score,
      results_attributes: [:id, :state]
  end

  def update_state_result
    @exam = Exam.includes(results: [question: :answers])
      .find_by id: params[:id]
    if @exam.nil?
      flash[:danger] = t "flash.cant_access"
      redirect_to admin_exams_path
    else
      @exam.update_results if @exam.uncheck?
      redirect_to admin_exams_path if @exam.init? || @exam.testing?
    end
  end

  def update_score
    @exam.update_attributes score: @exam.results.correct.count
  end
end
