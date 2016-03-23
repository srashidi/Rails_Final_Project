class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	validates :message, presence: true
	validates :post_id, presence: true
	validates :user_id, presence: true
end
