class PostsController < ApplicationController
	before_action :correct_user, only: :destroy

	def create
		session[:return_to] ||= request.referer
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
		end
		redirect_to session.delete(:return_to)
	end

  def index
  	@new_post = current_user.posts.build
  	ids = [current_user.id]
  	current_user.friends.each { |friend| ids << friend.id }
  	@posts = Post.where(user_id: ids).order(updated_at: :desc).paginate(page: params[:page])
  	@comment = Comment.new
  end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted!"
		redirect_to request.referrer || root_url
	end

  private

  	def post_params
  		params.require(:post).permit(:message)
  	end

  	def correct_user
			@post = current_user.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end
end
