class CommentsController < ApplicationController
  load_and_authorize_resource only: :destroy

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      respond_to do |f|
        f.html { redirect_to post_path(@comment.post) }
        f.js
      end
    else
      redirect_to post_path(params[:post_id]), notice: 'Comment was not saved'
    end
  end

  def destroy
    @comment.destroy

    respond_to do |f|
      f.html { redirect_to post_path(params[:post_id]) }
      f.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
