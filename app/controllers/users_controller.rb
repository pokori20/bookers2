class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    # 本の投稿数をカウントするため
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_day_ago_book = @books.created_2_day_ago
    @three_day_ago_book = @books.created_3_day_ago
    @four_day_ago_book = @books.created_4_day_ago
    @five_day_ago_book = @books.created_5_day_ago
    @six_day_ago_book = @books.created_6_day_ago

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

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    # 左項いつ作成されたかの値　右項は空欄。自分で投稿日時(create_at)に関するカラムを作成しなくても、レコード作成時に自動で投稿日時の情報が付与されている。
    if params[:created_at] == ""
      @search_book = "日付を選択してください"#①
    else
      create_at = params[:created_at]
      # @booksの中から(where)探す。何を？列名(created_at)投稿日時がLIKE合致するもの　"検索値%"　前方一致
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
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