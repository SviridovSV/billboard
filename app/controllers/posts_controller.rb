class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :show]
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:search_phrase].present?
      @posts = SearchService.new(params[:search_phrase],
                                 params[:search_param]).filter_by_search_param
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully destroyed'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:text, :user_id, :image,
                                 :tag_list, :search_phrase, :search_param)
  end
end
