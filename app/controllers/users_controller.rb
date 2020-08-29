class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user and @user.update(impersonating_param)
      @resize = MiniMagick::Image.read(@user.avatar.download)
      @resize = @resize.resize "200x200^"
      @filename = @user.avatar.filename
      @content_type = @user.avatar.content_type
      @user.avatar.purge
      @user.avatar.attach(io: File.open(@resize.path), filename:  @filename, content_type: @content_type)
      render :show
    end
  end

  private

  def impersonating_param
    params.require(:user).permit(:impersonating, :avatar, :cover_photo)
  end
end
