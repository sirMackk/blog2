class CommentsController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		if params[:comment][:name] == 'frodolives'
			@comment = Comment.new(comment_params)
			@comment.post_id = params[:post_id]
			if @comment.save
				flash[:success] = 'Your comment has been saved'
				redirect_to show_post_path post.slug
			else
				flash[:error] = 'Your comment could not be saved'
				redirect_to show_post_path post.slug
			end
		else
			post.spam_count += 1
			post.save
			flash[:error] = 'Comment rejected as spam'
			redirect_to show_post_path post.slug
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@post_id = @comment.post_id #what is this for?
		if @comment.destroy
			flash[:success] = 'Comment deleted'
		else
			flash[:error] = 'Comment could not be deleted'
		end
		redirect_to admin_show_path(@post_id)
	end

	private

	def comment_params
		params.require(:comment).permit(:email, :nick, :body, :post_id)
	end

end
