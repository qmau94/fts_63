class ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:index, :show]
  before_action :check_status, only: [:show]

  def index
    @exams = current_user.exams.includes :subject
  end

  def new
  end

  def show
    @exam.update_time_status
    @remaining_time = @exam.remaining_time
  end

  def update
    @exam.spent_time = @exam.calculated_spent_time
    if @exam.update_attributes exam_params
      if @exam.time_out? || params[:finish]
        # UserWorker.perform_async UserWorker::FINISH_EXAM,
        #   current_user.id, @exam.id
        flash[:success] = t "finish.success"
        @exam.uncheck!
      end
    else
      flash[:danger] = t "finish.error"
    end
    @exam.create_activity key: "exam.create", owner: current_user
    redirect_to exams_path
  end

  def create
    subject = Subject.find_by id: params[:exam][:subject_id]
    if subject.nil?
      flash[:danger] = t "exam.create.error"
      redirect_to subjects_path
    else
      @exam.save
      flash[:success] = t "exam.create.success"
      redirect_to exams_path
    end
  end

  private
  def exam_params
    params.require(:exam).permit :status, :spent_time, :score, :user_id,
      :subject_id, results_attributes: [:id, multiple_answers: []]
  end

  def check_status
    @exam = current_user.exams.find_by id: params[:id]
    if @exam.nil?
      flash[:danger] = t "flash.cant_access"
      redirect_to exams_path
    else
      case @exam.status
      when "init"
        @exam.create_result_for_exam
        UserWorker.perform_async UserWorker::START_EXAM,
          current_user.id, @exam.id
      when "testing"
        flash.now[:danger] = t "exam.finished" if @exam.time_out?
      when "uncheck"
        flash[:danger] = t "flash.cant_access"
        redirect_to exams_path
      end
      @exam = current_user.exams.includes(results: [question: :answers])
        .find_by id: params[:id]
    end
  end
end
