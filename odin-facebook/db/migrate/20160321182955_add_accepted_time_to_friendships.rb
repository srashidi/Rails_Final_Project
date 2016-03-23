class AddAcceptedTimeToFriendships < ActiveRecord::Migration
  def change
  	add_column :friendships, :accepted_time, :datetime
  end
end
