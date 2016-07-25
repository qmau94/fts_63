class Admin::NotificationsController < ApplicationController
  authorize_resource class: false

  def index
    @activities = PublicActivity::Activity.by_key("exam.create")
      .newest.page(params[:page]).per Settings.per_page
  end
end
