class TblUser < ApplicationRecord
	before_save { self.email = email.downcase }
    validates :firstName, presence: true, length: { maximum: 25 }
    validates :lastName, presence: true, length: { maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validates :phoneNumber, presence: true, length: { minimum: 9 }
    validates :address, presence: true, length: { maximum: 25 }
    validates :postalCode, presence: true, length: { minimum: 6 }

     # Returns the hash digest of the given string.
   def TblUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
   end

   def full_name
      "#{firstName} #{lastName}"
    end
end
