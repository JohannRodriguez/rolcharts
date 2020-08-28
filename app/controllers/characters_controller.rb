class CharactersController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def show
    @character = Character.find(params[:id])
  end

  def new
    @character = current_user.characters.new
  end

  def create
    @character = current_user.characters.build(character_params)
    if @character.save
      flash.notice = 'Character succesfully created'
      redirect_to characters_path
    else  
      flash.alert = @character.errors.full_messages
      render :new
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(character_params)
      flash.notice = 'Character succsesfully edited'
      redirect_to character_path(params[:id])
    else
      flash.alert = @character.errors.full_messages
      render :edit
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    flash.notice = 'Character deleted'
    redirect_to user_path(current_user)
  end

  private

  def character_params
    params.require(:character).permit(:name, :description)
  end
end
