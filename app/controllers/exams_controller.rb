class ExamsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @exams = current_user.exams
  end

  def new
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
    params.require(:exam).permit :status, :spent_time, :score,
      :user_id, :subject_id
  end
end
