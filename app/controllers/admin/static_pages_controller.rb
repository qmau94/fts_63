class Admin::StaticPagesController < ApplicationController
  before_action :verify_admin
  
  def home
  end
end
