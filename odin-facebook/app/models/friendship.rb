class Friendship < ActiveRecord::Base
	belongs_to :friending, class_name: "User", foreign_key: "from_id"
	belongs_to :friended, class_name: "User", foreign_key: "to_id"
end
