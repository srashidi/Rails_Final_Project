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
  	from_id = current_user.id
  	to_id = params[:id] # The id of the user the current user want to be friends with
  	unless from_id == to_id
			friendship = Friendship.create(	from_id: from_id,
																			to_id: to_id,
																			accepted: false )
  	end
  	redirect_to request.referer || root_url
  end

  # A current user accepting a friend request
  def friend_request_accept
  	to_id = current_user.id
  	from_id = params[:id]
  	friendship = Friendship.where( to_id: to_id, from_id: from_id ).first
  	friendship.update_attributes(accepted: true, accepted_time: Time.new)
  	redirect_to request.referer || root_url
  end

  # A current user rejecting a friend request
  def friend_request_reject
  	to_id = current_user.id
  	from_id = params[:id]
  	friendship = Friendship.where( to_id: to_id, from_id: from_id ).first
  	friendship.destroy
  	redirect_to request.referer || root_url
  end
end
