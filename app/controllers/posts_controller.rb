class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new,:edit,:index]

  def index
    # @posts = Post.all
    @posts = Post.all
    @posts = Post.page(params[:page]).per(3)

  end

  def tops
  end

  def new
    @post = Post.new
    @wifi = @post.wifis.build
    @toilet = @post.toilets.build
    @trouble = @post.troubles.build

    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end

  end

  def create
    @post = Post.new(post_params)
    create_post = @post.save!

    @wifi = create_post.wifi.build(wifi_params)
      @wifi.save!
    @toilet = create_post.toilet.build(toilet_params)
      @toilet.save!
    @trouble = create_post.trouble.build(trouble_params)
      @trouble.save!

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
    # @wifi = Wifi.find_by(post_id: @post.id)
    # @toilet = Toilet.find_by(post_id: @post.id)
    # @trouble = Trouble.find_by(post_id: @post.id)
    # @like = current_user.likes.find_by(post_id: @post.id)

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
    # binding.pry

    @post = Post.new(post_params)
    @wifi = @post.wifis.build(wifi_params)
    @toilet = @post.toilets.build(toilet_params)
    @trouble = @post.troubles.build(trouble_params)
    # create_post = @post.save!
    # @wifi = create_post.wifi.build(wifi_params)
    #   @wifi.save!
    # @toilet = create_post.toilet.build(toilet_params)
    #   @toilet.save!
    # @trouble = create_post.trouble.build(trouble_params)
    #   @trouble.save!
    @post.user_id = current_user.id

    render :new if @post.invalid?

  end

  private
    def post_params
      params.require(:post).permit(:content,:user_id,:image,:spot)
    end

    def wifi_params
      params.require(:post)[:wifi].permit(:condition_1, :condition_2, :condition_3)
    end

    def toilet_params
      params.require(:post)[:toilet].permit(:information, :comfortable, :box_number,:baggage)
    end

    def trouble_params
      params.require(:post)[:trouble].permit(:atm, :station, :bus, :pharmacy)
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
