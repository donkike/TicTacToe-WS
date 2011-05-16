class GamesController < ApplicationController
  
  respond_to :xml
  
  def create
    @game = Game.new(params[:game])
    if @game.valid?
      @game.save
      render :xml => @game, :only => [:player1, :player2, :board]
    else
      render :xml => @game.errors, :status => :unprocessable_entity
    end
  end
  
end
