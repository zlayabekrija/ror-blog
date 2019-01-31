class User < ApplicationRecord
    attr_accessor :remember_token,:activation_token,:reset_token
    before_create :create_activation_digest
    before_save { self.email = email.downcase }
    validates :name, length: {minimum: 5},format: /\w+/i,uniqueness: true
    validates :email, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, uniqueness: { case_sensitive: false }
    mount_uploader :picture, PictureUploader

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, confirmation: true
    validate  :picture_size

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
      # Returns a random token.
      def User.new_token
        SecureRandom.urlsafe_base64
      end

      def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
      end

       # Returns true if the given token matches the digest.
       def authenticated?(attribute,remember_token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(remember_token)
      end

      def forget
        update_attribute(:remember_digest, nil)
      end
      
      def activate
        update_attribute(:activated,    true)
        update_attribute(:activated_at, Time.zone.now)
      end
    
      # Sends activation email.
      def send_activation_email
        UserMailer.account_activation(self).deliver_now
      end
      
      def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
      end
    
      # Sends password reset email.
      def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
      end
      def password_reset_expired?
        reset_sent_at < 2.hours.ago
      end

      private

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)

    end

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    
end
