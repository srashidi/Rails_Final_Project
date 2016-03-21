class User < ActiveRecord::Base
  # Included devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

	# Validations for name and username
  validates :name, length: { maximum: 50 }
  validates :username, length: { maximum: 50 },
  										 uniqueness: { case_sensitive: false }

  # Friendship associations
	has_many :initiated_friendships, class_name: "Friendship",
																	 foreign_key: "from_id",
																	 dependent: :destroy
	has_many :received_friendships, class_name: "Friendship",
																	foreign_key: "to_id",
																	dependent: :destroy
	has_many :friendings, through: :initiated_friendships, source: :friending
	has_many :friendeds, through: :received_friendships, source: :friended

	# Password digest for given password string
  def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def friendships
		Friendship.where("from_id=? OR to_id=?", self.id, self.id)
	end

	def pending_friendships
		self.friendships.where(to_id: self.id, accepted: false)
  end
end
