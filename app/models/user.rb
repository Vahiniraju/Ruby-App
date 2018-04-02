class User < ApplicationRecord

  has_secure_password
  has_many :questions
  has_many :user_selections
  attr_accessor :remember_token, :activation_token, :reset_token
  accepts_nested_attributes_for :questions
  before_create :create_activation_digest

  #Format Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME = /\A\S{3,30}\z/
  VALID_NAME = /\A[a-zA-Z]/
  VALID_PASSWORD = /\A[a-zA-Z][a-zA-z\d\-_@!#~^$%&*()]{6,}\z/

  #Attribute Validations
  # default_scope { where(active: true)}
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

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest,nil)
  end


  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def activate
    update_columns(active: true,activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

end
