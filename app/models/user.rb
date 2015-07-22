class User < ActiveRecord::Base

	has_one :trainer
	has_one :account_information
	has_many :logins

	attr_accessor :password
	before_create :encrypt_password
	before_update :encrypt_password

	validates_confirmation_of :password

	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :mail_address, :presence => true

	after_validation :set_defaults

	scope :online, -> { where("last_seen_at > ?", 5.minutes.ago)}

	def self.authenticate(mail_address,password)
		user = find_by_mail_address mail_address
		if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
		end
	end

	def name
		return self.first_name + " " + self.last_name
	end

	def is_trainer
		if !self.trainer.nil?
			return true
		else
			return false
		end
	end

	def online?
		self.last_seen_at != nil and self.updated_at > 5.minutes.ago
	end

	private
		def set_defaults
			self.admin_permissions ||= false
		end

end