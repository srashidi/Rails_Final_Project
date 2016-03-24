class User < ActiveRecord::Base
  # Included devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

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

  def active_friendships
  	self.friendships.where(accepted: true)
  end

  def friends
		ids = []
		self.active_friendships.each do |friendship|
			if friendship.from_id == self.id
				id = friendship.to_id
				ids << id
			elsif friendship.to_id == self.id
				id = friendship.from_id
				ids << id
			end
		end
		User.find(ids)
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			user.name = auth.info.name   # assuming the user model has a name
		end
	end
end
