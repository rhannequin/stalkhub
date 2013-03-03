class Stalking < ActiveRecord::Base
  attr_accessible :user_id, :owner, :repo

  belongs_to :user
end
