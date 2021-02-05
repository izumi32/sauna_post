class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = self.email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 6},
                       allow_nil: true

  # 文字列をハッシュ化
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # トークンを作成
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # remember_digestにハッシュ化したトークンを保存
  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end

  # remember_digestの情報を破棄
  def forget
    self.update_attribute(:remember_digest, nil)
  end

  # 引数のトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
