class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new,:edit,:show]

  def index
    @posts = Post.all
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

  end

  def show
    @comment = @post.comments.build
    @comments = @post.comments
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to posts_path, notice: '編集しました！'
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '削除しました！'
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    render :new if @post.invalid?
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
      wifis_attributes: [:condition_1, :condition_2, :condition_3 ],
      toilets_attributes: [:information, :comfortable, :box_number, :baggage ],
      troubles_attributes: [:atm, :station, :bus, :pharmacy ]
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
