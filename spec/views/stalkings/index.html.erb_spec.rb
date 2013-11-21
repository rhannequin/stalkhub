require 'spec_helper'

describe "stalkings/index" do
 before(:all) do
    assign(:stalkings, FactoryGirl.create_list(:stalking, 2))
  end

  it "renders a list of stalkings" do
    render

    rendered.should match(/p/)
  end
end
