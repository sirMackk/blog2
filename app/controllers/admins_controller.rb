class AdminsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@posts = Post.order('created_at DESC').page(params[:page]).per(2)
	end

end