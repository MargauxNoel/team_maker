class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    @player.save
    redirect_to player_path(@player)
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.update(params[:player])
    redirect_to player_path(@player)
  end

  def destroy

  end

  private

  def player_params
    params.require(:player).permit(:name, :partner)
  end

end
