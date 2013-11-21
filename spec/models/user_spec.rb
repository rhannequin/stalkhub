require 'spec_helper'

describe User do
  it "has a valid factory" do
    user = FactoryGirl.build(:user)
    user.should be_valid
  end
end
