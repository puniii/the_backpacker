class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new,:edit,:index]

  def index
    @posts = Post.all

  end

  def tops
  end

  def new
    @post = Post.new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|

    if @post.save
      ContactMailer.post_mail(@post).deliver_later
      format.html { redirect_to @post, notice: '投稿しました' }
      format.json { render :show, status: :created, location: @post }

    else
      render'new'
    end
    end

    if params[:cache][:image].present?
      @post.image.retrieve_from_cache! params[:cache][:image]
      @post.save!
    end
  end

  def show
    @post = Post.find(params[:id])
    @like = current_user.likes.find_by(post_id: @post.id)

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      @post.update(post_params)
      redirect_to posts_path,notice: "つぶやきを編集しました！"
  end

  def destroy
      @post.destroy
      redirect_to posts_path,notice:"つぶやきを削除しました！"
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    render :new if @post.invalid?

  end

  private
    def post_params
      params.require(:post).permit(:content, :user_id, :image, :spot)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def logged_in_user
      unless current_user
        flash[:referer] = 'ログインしてください'
        render new_session_path
      end
    end
end
