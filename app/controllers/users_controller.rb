class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user and @user.update(impersonating_param)
      @user.avatar_resize
      render :show
    else
      flash.notice = @user.errors.full_messages
      redirect_to user_path(params[:id])
    end
  end

  private

  def impersonating_param
    params.require(:user).permit(:impersonating, :avatar, :cover_photo)
  end
end
