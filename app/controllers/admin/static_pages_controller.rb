class Admin::StaticPagesController < ApplicationController
  authorize_resource class: false

  def home
  end
end
