class SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
  end
end
