# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)     not null
#  is_confirmed    :integer         default(0), not null
#  is_admin        :integer         default(0), not null
#  is_blocked      :integer         default(0), not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)     not null
#  remember_token  :string(255)
#  last_login_at   :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation,
                  :is_confirmed, :is_admin, :is_blocked, :last_login_at, :created_at
  has_secure_password

  has_many :downloads
  has_many :collectors, :through => :downloads

  scope :downloads_count,
        joins('LEFT JOIN downloads ON downloads.user_id = users.id')
          .select('users.*, COUNT(users.id) AS downloads_total')
          .group('downloads.user_id, users.id, users.email, users.is_confirmed,
                  users.is_admin, users.is_blocked, users.created_at,
                  users.updated_at, users.password_digest, users.remember_token,
                  users.last_login_at')

  before_save { |user| user.email = email.downcase }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
