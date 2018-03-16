# class ToiletsController < ApplicationController
#   before_action :logged_in_user, only: [:create, :destroy]
#
#
# def create
#   toilet = current_user.toilets.create(post_id: params[:post_id])
#   redirect_to posts_path
# end
#
#
# def destroy
#   toilet = current_user.toilets.find_by(post_id: params[:post_id]).destroy
#   redirect_to post_path
# end
#
# private
#
# def logged_in_user
#   unless current_user
#     flash[:referer] = 'ログインしてください'
#     render new_session_path
#   end
# end
# end
