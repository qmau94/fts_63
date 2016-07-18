class Admin::SubjectsController < ApplicationController
  before_filter :find_subject, except: [:new, :index, :create]
  load_and_authorize_resource find_by: :slug

  def index
    @subjects = @subjects.page(params[:page]).per Settings.per_page
  end
  
  def destroy
    if @subject.destroy
      flash[:success] = t "subject.delete.success"
      redirect_to admin_subjects_path
    end
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subject.update.success"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def create
    if @subject.save
      flash[:success] = t "subject.create.success"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  private
  def find_subject
    @subject = Subject.friendly.find_by slug: params[:id]
    if @subject.nil?
      flash[:danger] = t "flash.subject_nil"
      redirect_to admin_subjects_path
    end
  end

  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end
end
