class CommentsController < ApplicationController
 before_action :correct_user, only: :destroy

  def create
  	session[:return_to] ||= request.referer
  	@comment = Comment.new(comment_params)
  	if @comment.save
  		flash[:success] = "Comment successfully made!"
  	end
  	redirect_to session.delete(:return_to)
  end

  def destroy
  	@comment.destroy
  	redirect_to request.referrer || root_url
  end

  private

  	def comment_params
  		params.require(:comment).permit(:message, :post_id, :user_id)
  	end

  	def correct_user
			@comment = Comment.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end
end
