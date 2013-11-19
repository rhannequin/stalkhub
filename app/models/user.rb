require 'digest'
class User < ActiveRecord::Base
  attr_accessor :gh # Octokit

  validates :avatar_url, :token, :presence => true
  validates :username,   :presence   => true,
                         :uniqueness => { :case_sensitive => false }

  has_many :stalkings, :dependent => :destroy

  def self.authenticate(auth_hash)
    unless user = find_by_uid(auth_hash.uid)
      user = User.new :uid => auth_hash.uid
    end
    user.avatar_url = auth_hash.info.image
    user.token = auth_hash.credentials.token
    user.username = auth_hash.info.nickname
    user.save
    user
  end
end