class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    debugger
    @post = current_user.posts.new post_params
    if @post.save
      flash[:success]  = 'Post saved'
      redirect_to show_post_path @post.slug
    else
      flash[:error] = 'Post not saved'
      render 'new'
    end
  end

  def show
    @post = Post.find_by_slug params[:slug]
    @comment = @post.comments.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes post_params
      flash[:success] = 'Post updated'
      redirect_to show_post_path @post.slug
    else
      flash[:error] = 'Post not updated'
      render 'edit'
    end
  end

  def destroy
    if Post.find(params[:id]).destroy
      flash[:success] = "Post deleted!"
    else 
      flash[:error] = "Post could not be deleted"
    end
    redirect_to get_admin_path
  end

  private 

  def post_params
    params.require(:post).permit(:title, :description, :body)
  end


end
