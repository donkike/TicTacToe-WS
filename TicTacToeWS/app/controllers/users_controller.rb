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
    @user = User.new(params[:user])
    if @user.save
      render :xml => @user, :only => [:id, :name, :playing]
    else
      render :xml => @user.errors, :status => :unprocessable_entity
    end
  end
  
  def destroy
    User.find(params[:id]).delete
    render :xml => {} 
  end
  
end
