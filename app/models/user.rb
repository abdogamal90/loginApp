class User < ApplicationRecord
  has_many :articles
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable, 
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

 




end
