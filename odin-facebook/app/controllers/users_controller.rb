class UsersController < ApplicationController
	def new
  end

  def show
  	@user = User.find(params[:id])
  	@new_post = current_user.posts.build if @user == current_user
  	@posts = @user.posts.order(updated_at: :desc)
		@comment = Comment.new
  end

  def index
  	@users = User.all.order(:name).paginate(page: params[:page])
  end

  def edit
  end
end
