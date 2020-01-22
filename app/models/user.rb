class User < ApplicationRecord

    attr_accessor :remember_token, :activation_token, :reset_token

    email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    validates :email, presence: true, uniqueness: true, format: {with: email_regex}
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true

    before_create :create_activation_digest

    has_secure_password
    has_many :admin_privileges, dependent: :destroy
    has_many :owned_worlds, :class_name => "World", dependent: :destroy
    has_many :admin_worlds, :through => :admin_privileges, :source => :world
    has_many :edits
    has_many :templates, :class_name => "Page", dependent: :destroy

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    def is_admin?(world)
        !self.admin_privileges.where(world: world).empty?
    end
    

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Activates an account.
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # Sets the password reset attributes.
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # Sends password reset email.
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    private

    def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
    end

end
