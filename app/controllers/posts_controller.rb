class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :feed, :about]
  #caches_action :show, expires_in: 1.hour
  #caches_action :index, expires_in: 1.hour

  def index
    @posts = Post.where(post_type_cd: 0).order('created_at DESC').page(params[:page]).per(8)
  end

  def new
    @post = current_user.posts.new id: Post.last.nil? ? 0 : Post.last.id + 1
  end

  def create
    @post = current_user.posts.new post_params
    if @post.save
      flash[:success]  = 'Post saved'
      redirect_to show_post_path(@post.slug)
    else
      flash[:error] = 'Post not saved'
      render 'new'
    end
  end

  def show
    @post = Post.includes(:comments).find_by_slug(params[:slug]) || not_found
    @comment = Comment.new
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to show_post_path(@post.slug)
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

  def feed
    @title = 'matts code cave'
    @posts = Post.where(post_type_cd: 0).order('created_at DESC').limit(7)
    @updated = @posts.first.updated_at unless @posts.empty?
    
    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :description, :body, :post_type_cd)
  end

end
