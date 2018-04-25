class User < ApplicationRecord

  has_many :posts, dependent: :destroy
	attr_accessor :remember_token 
	before_save { email.downcase! }
	has_secure_password

	validates :name,     presence: true,
					     length: { maximum: 50 }

	validates :email,    presence: true,
					     length: { maximum: 255 },
					     format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
					     uniqueness: { case_sensitive: false }

	validates :password, presence: true,
					     length: { minimum: 6 },
					     allow_nil: true

  def User.digest(string)
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
  	SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
  	digest = send("#{attribute}_digest")
  	return false if digest.nil?
  	BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  private##################private methods########################

end
