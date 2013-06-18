class CommentsController < ApplicationController

	def create
		@comment = Comment.new comment_params
		@comment.post_id = params[:post_id]
		if @comment.save
			flash[:success] = 'Your comment has been saved'
			redirect_to post_path params[:post_id]
		else
			flash[:error] = 'Your comment could not be saved'
			redirect_to post_path params[:post_id]
		end
	end

	def destroy
		@comment = Comment.find params[:id]
		@post_id = @comment.post_id
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