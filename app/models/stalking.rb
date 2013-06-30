class Stalking < ActiveRecord::Base
  attr_accessor   :gh
  attr_accessible :user_id, :owner, :repo, :last_commit_seen

  belongs_to :user
end
