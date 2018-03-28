class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録完了しました"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @likes_posts = @user.like_posts
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
       redirect_to @user, notice: '編集しました！'
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :image,
        :area,
        :introduction)
    end
end
