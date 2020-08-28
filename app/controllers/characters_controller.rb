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
    @character = current_user.characters.new(character_params)
    if !Character.where(user_id: current_user, name: character_params[:name]).empty?
      flash.alert = 'You already have this character'
      render :new
    else
      if @character.save
        flash.alert = 'Character succesfully created'
        redirect_to characters_path
      else  
        flash[:notice] = @character.errors.full_messages
        render :new
      end
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
