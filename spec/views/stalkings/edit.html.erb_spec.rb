require 'spec_helper'

describe "stalkings/edit" do
  before(:each) do
    @stalking = assign(:stalking, FactoryGirl.create(:stalking))
  end

  it "renders the edit stalking form" do
    render

    assert_select "form[action=?][method=?]", stalking_path(@stalking), "post" do
      assert_select "input#stalking_owner[name=?]", "stalking[owner]"
      assert_select "input#stalking_repo[name=?]", "stalking[repo]"
    end
  end
end
