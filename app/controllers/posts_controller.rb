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
    @post = current_user.post.new post_params
    if @post.save
      flash[:success]  = 'Post saved'
      redirect_to "/#{@post.slug}"
    else
      flash[:error] = 'Post not saved'
      render 'new'
    end
  end

  def show
    @post = Post.find_by_slug params[:slug]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes post_params
      flash[:success] = 'Post updated'
      redirect_to "/#{@post.slug}"
    else
      flash[:error] = 'Post not updated'
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
  end

  private 

  def post_params
    params.require(:post).permit(:title, :description, :body)
  end


end
