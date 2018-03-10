module SessionsHelper

  def log_in(user) #userを渡す
    session[:user_id] = user.id
  end

  def current_user #ログイン中のuserがいる場合
    @current_user ||= User.find_by(id: session[:user_id]) #userが存在しない場合falseを返す
  end

  def logged_in? #ログインしていればtrueを返す
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
