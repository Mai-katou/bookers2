class BooksController < ApplicationController

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id)
      flash[:bookcreated] ="You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @new_book = Book.new
    @books = Book.page(params[:page])
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to book_path(@book.id)
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book.id)
      flash[:bookupdated] = "You have updated book successfully."
    else
      @book = Book.find(params[:id])
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
