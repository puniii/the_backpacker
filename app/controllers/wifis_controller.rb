class WifisController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    wifi = current_user.wifis.create(post_id: params[:post_id])
    redirect_to posts_path
  end


  def destroy
    wifi = current_user.wifis.find_by(post_id: params[:post_id]).destroy
    redirect_to post_path
  end

  private

  def logged_in_user
    unless current_user
      flash[:referer] = 'ログインしてください'
      render new_session_path
    end
  end
end
