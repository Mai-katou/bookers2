class UsersController < ApplicationController
  def show
    @user = User(params[:id])
  end

  def edit
    @user = User(params[:id])
  end
end
