class UsersController < ApplicationController
  
  respond_to :xml
  
  def index
    @users = User.all
    respond_with @users, :only => [:id, :name, :playing] 
  end
  
  def show
    @user = User.find(params[:id])
    respond_with @user, :only => [:id, :name, :playing]
  end
  
  def create
    @user = User.create(params[:user])
    render :xml => @user, :only => [:id, :name, :playing]
  end
  
end
