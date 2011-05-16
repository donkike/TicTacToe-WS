class GamesController < ApplicationController
  
  respond_to :xml
  
  def create
    @game = Game.create(params[:id])
    render :xml => @game, :only => [:player1, :player2, :board]
  end
  
end
