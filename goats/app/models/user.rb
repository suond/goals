# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    # validates :session_token, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6 , allow_nil: true }

    attr_reader :password
    after_initialize :session_token


    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil if user.nil? || !user.is_password?(password)
        user
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64(16)
        self.save!
        self.session_token
    end

    def generate_session_token
        SecureRandom.urlsafe_base64(16)
    end
end
