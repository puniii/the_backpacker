class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:blog_id])
    @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした' }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end