class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: '投稿できませんでした' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    render :index if @comment.destroy
  end

  def comment_params
    params.require(:comment).permit(
      :post_id,
      :user_id,
      :content,
      :image,
      :image_cache,
      :wifi,
      :toilet,
      :trouble
    )
  end
end
