class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(impersonating_param)
      if @user.impersonating.nil?
        flash.notice = "You will now be displayed as #{@user.username}"
      else
        flash.notice = "You will now be displayed as #{@user.impersonating}"
      end
    end
    render :show
  end

  private

  def impersonating_param
    params.require(:user).permit(:impersonating)
  end
end
