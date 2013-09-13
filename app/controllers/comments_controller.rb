class CommentsController < ApplicationController

	def create
		if params[:comment][:name] == 'frodolives'
			@comment = Comment.new comment_params
			@comment.post_id = params[:post_id]
			@post_slug = Post.find(params[:post_id]).slug
			if @comment.save
				flash[:success] = 'Your comment has been saved'
				redirect_to show_post_path @post_slug
			else
				flash[:error] = 'Your comment could not be saved'
				redirect_to show_post_path @post_slug
			end
		else
			flash[:error] = 'Comment rejected as spam'
			redirect_to show_post_path @post_slug
		end
	end

	def destroy
		@comment = Comment.find params[:id]
		@post_id = @comment.post_id #what is this for?
		if @comment.destroy
			flash[:success] = 'Comment deleted'
			redirect_to :back
		else
			flash[:error] = 'Comment could not be deleted'
			redirect_to :back
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:email, :nick, :body, :post_id)
	end

end