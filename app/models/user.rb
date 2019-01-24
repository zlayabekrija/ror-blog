class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, length: {minimum: 5},format: /\w+/i,uniqueness: true
    validates :email, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, confirmation: true
end
