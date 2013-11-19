class Stalking < ActiveRecord::Base
  attr_accessor   :gh

  belongs_to :user
end
