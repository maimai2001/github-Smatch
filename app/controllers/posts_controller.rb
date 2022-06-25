class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all
    if params[:tag]
      Tag.create(name: params[:tag])
    end
    posts = Post.where(user_id: current_user.id)
    @sum = posts.group(:tag).sum(:time)
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to :action => "show", :id => post.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to action: :index
  end

  private
  def post_params
    params.permit(:about, :time, :tag, :name)
  end

end
