
class PostsController < ApplicationController
  before_action :require_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.feed.limit(50)
    @post = Post.new
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post was created successfully"
      redirect_to root_path
    else
      @posts = current_user.feed.limit(50)
      render 'index'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was updated successfully"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post was deleted"
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
  
  def require_same_user
    if current_user != @post.user
      flash[:alert] = "You can only edit or delete your own posts"
      redirect_to root_path
    end
  end
end
