class SessionsController < ApplicationController
  def top
    @user = current_user
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id

        redirect_to new_post_path(user.id)

      else
        flash.now[:danger] = 'ログインできませんでした'
        render 'new'
      end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
