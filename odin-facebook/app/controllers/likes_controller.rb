class LikesController < ApplicationController
	before_action :correct_user, only: :destroy

  def create
  	@post = Post.find(params[:post_id])
  	@like = @post.likes.create(user_id: current_user.id, post_id: @post)
  	redirect_to request.referer || root_url
  end

  def destroy
  	@like.destroy
  	redirect_to request.referrer || root_url
  end

  private

  	def correct_user
  		@post = Post.find(params[:post_id])
			@like = @post.likes.find_by(user_id: current_user.id)
			redirect_to root_url if @like.nil?
		end
end
