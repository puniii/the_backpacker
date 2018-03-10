class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]


def create
  like = current_user.likes.create(post_id: params[:post_id])
  redirect_to posts_path, notice: "いいね！しました"
end


def destroy
  like = current_user.likes.find_by(post_id: params[:post_id]).destroy
  redirect_to post_path, notice: "いいね！を取り消ししました"
end

private

def logged_in_user
  unless current_user
    flash[:referer] = 'ログインしてください'
    render new_session_path
  end
end
end
