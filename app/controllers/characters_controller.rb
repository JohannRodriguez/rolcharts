class CharactersController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def show
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
  end

  def update
  end

  def destroy
  end

  private

  def character_params
    params.require(:character).permit(:name, :description)
  end
end
