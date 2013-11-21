require 'spec_helper'

describe "stalkings/new" do
  before(:each) do
    assign(:stalking, Stalking.new)
  end

  it "renders new stalking form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stalkings_path, "post" do
      assert_select "input#stalking_owner[name=?]", "stalking[owner]"
      assert_select "input#stalking_repo[name=?]", "stalking[repo]"
    end
  end
end
