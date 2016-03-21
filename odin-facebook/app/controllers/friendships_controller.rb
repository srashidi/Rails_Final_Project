class FriendshipsController < ApplicationController
  def create
  end

  def show
  end

  def pending
  	@friendships = current_user.friendships.where(to_id: current_user.id, accepted: false)
  end

  # A current user making a friend request
  def friend_request
  	session[:return_to] ||= request.referer
  	from_id = current_user.id
  	to_id = params[:id] # The id of the user the current user want to be friends with
  	friendship = Friendship.create(	from_id: from_id,
  																	to_id: to_id,
  																	accepted: false )
  	redirect_to session.delete(:return_to)
  end

  # A current user accepting a friend request
  def friend_request_accept
  	session[:return_to] ||= request.referer
  	to_id = current_user.id
  	from_id = params[:id]
  	friendship = Friendship.where( to_id: to_id, from_id: from_id ).first
  	friendship.update_attributes(accepted: true)
  	redirect_to session.delete(:return_to)
  end

  # A current user rejecting a friend request
  def friend_request_reject
  	session[:return_to] ||= request.referer
  	to_id = current_user.id
  	from_id = params[:id]
  	friendship = Friendship.where( to_id: to_id, from_id: from_id ).first
  	friendship.destroy
  	redirect_to session.delete(:return_to)
  end
end
