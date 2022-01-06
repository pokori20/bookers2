class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    # 本の投稿数をカウントするため
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @a_week_ago_book = @books.created_a_week_ago
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end


end
