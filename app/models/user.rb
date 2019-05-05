# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  name               :string(255)
#  email              :string(255)
#  password_digest    :string(255)
#  confirmation_token :string(255)
#  confirmed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord

  has_secure_password

  before_validation do
    self.confirmation_token = SecureRandom.uuid
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :carts
  has_many :addresses, as: :addressable
  has_many :orders

  def is_admin?
    self.email == ADMIN_EMAIL
  end

  def reset_password!
    self.update(password_confirmation_token: SecureRandom.uuid)
    UserMailer.with(user: self).reset_password.deliver_now
  end
end
