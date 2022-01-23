class UsersController < ApplicationController

  def index
    @users= User.page(params[:page])
    @user = current_user
    @new_book = Book.new
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:userupdated] ="You have updated user successfully."
    else
    render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
