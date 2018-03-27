class User < ApplicationRecord

  has_secure_password

  #Format Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /\A\S{5,30}\z/
  VALID_NAME = /\A[a-zA-Z]/
  VALID_PASSWORD = /\A[a-zA-Z][a-zA-z\d\-_@!#~^$%&*()]{6,}\z/

  #Attribute Validations
  validates :first_name, :last_name, presence: true, format:{with: VALID_NAME}
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  validates :password, presence: true, format: {with:VALID_PASSWORD}
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_USERNAME}

end
