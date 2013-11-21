require 'spec_helper'

describe Stalking do
  it "has a valid factory" do
    stalking = FactoryGirl.build(:stalking)
    stalking.should be_valid
  end
end
