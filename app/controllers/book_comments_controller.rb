class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    @book_comment= BookComment.new

    # redirect_back(fallback_location: root_path)

  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy

    @book = Book.find(params[:book_id])
    @book_comment= BookComment.new

    # redirect_back(fallback_location: root_path)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end