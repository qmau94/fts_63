class NotificationsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.by_key("exam.update")
      .newest.by_user(current_user).page(params[:page]).per Settings.per_page
  end
end
