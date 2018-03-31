class User < ApplicationRecord

  has_secure_password
  has_many :questions
  has_many :user_selections
  attr_accessor :remember_token
  accepts_nested_attributes_for :questions

  #Format Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /\A\S{3,30}\z/
  VALID_NAME = /\A[a-zA-Z]/
  VALID_PASSWORD = /\A[a-zA-Z][a-zA-z\d\-_@!#~^$%&*()]{6,}\z/

  #Attribute Validations
  default_scope { where(active: true)}
  validates :first_name, :last_name, presence: true, format:{with: VALID_NAME}
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  validates :password, presence: true, format: {with:VALID_PASSWORD}, allow_nil: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_USERNAME}
  validates :score, :numericality => { :greater_than_or_equal_to => 0 }

  class << self
    def digest(string)
      hash_cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: hash_cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest,nil)
  end

end
