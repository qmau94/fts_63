class Admin::UsersController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    @search = User.search params[:q]
    @users = @search.result distint: true
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.deleted"
    else
      flash[:danger] = t "users.cant_delete"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :email, :username
  end
end
