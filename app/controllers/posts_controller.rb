class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new,:edit,:index]

  def index
    @posts = Post.all
    @pages = @posts.page(params[:page]).per(3)
    # @posts = Post.page(params[:page]).per(3)

    @search = Post.search(params[:q])
    @posts = @search.result
  end

  def new

    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
      @post.wifis.build
      @post.toilets.build
      @post.troubles.build
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
        render 'new'
      end
    end

    if params[:cache][:image].present?
      @post.image.retrieve_from_cache! params[:cache][:image]
      @post.save!
    end
  end

  def show
    @comment = @post.comments.build(user_id: current_user.id) if current_user  
    @comments = @post.comments.includes(:user).all
    # binding.pry
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to posts_path, notice: 'つぶやきを編集しました！'
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'つぶやきを削除しました！'
  end

  def confirm

    @post = Post.new(post_params)
    @post.user_id = current_user.id

    render :new if @post.invalid?

    # ssbinding.pry

  end

  private

  def post_params
    params.require(:post).permit(
      :content,
      :user_id,
      :image,
      :cache,
      :image_cach,
      :spot,
      wifis_attributes: [:condition_1, :condition_2, :condition_3, :post_id],
      toilets_attributes: [:information, :comfortable, :box_number, :baggage, :post_id],
      troubles_attributes: [:atm, :station, :bus, :pharmacy, :post_id]
    )
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
