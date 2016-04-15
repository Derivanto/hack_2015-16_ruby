class User < ActiveRecord::Base
  has_secure_password
  
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :f_name, presence: true
  validates :l_name, presence: true
  validates :email, presence: true, uniqueness: true
end