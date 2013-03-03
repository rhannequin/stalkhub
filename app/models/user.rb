require 'digest'
class User < ActiveRecord::Base
  attr_accessible :avatar_url, :login, :password, :token

  validates :avatar_url, :token, :presence => true
  validates :login,     :presence   => true,
                        :uniqueness => { :case_sensitive => false }
  validates :password,  :length     => { :within => 6..40 }

  has_many :stalkings, :dependent => :destroy

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
    self.password = nil
  end

  private

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{ENV['SECRET_HASH']}--#{password}") # Check if it works
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
