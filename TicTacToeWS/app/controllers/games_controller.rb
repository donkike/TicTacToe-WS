class GamesController < ApplicationController
  
  respond_to :xml
  
  def create
    @game = Game.new(params[:game])
    if @game.valid?
      @game.save
      render :xml => @game, :only => [:id, :player1, :player2, :board, :turn]
    else
      render :xml => @game.errors, :status => :unprocessable_entity
    end
  end
 
  def show
    if @game = Game.find(params[:id])
      respond_with @game
    else
      render :xml => {}
    end 
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(params[:game])
    render :xml => @game, :only => [:id, :player1, :player2, :board, :turn]
  end

  def get_by_name
    @game = Game.find_by_player1(params[:name]) || Game.find_by_player2(params[:name])
    render :xml => @game, :only => [:id, :player1, :player2, :board, :turn]
  end
  
end
