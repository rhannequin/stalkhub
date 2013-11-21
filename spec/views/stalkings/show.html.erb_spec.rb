require 'spec_helper'

describe "stalkings/show" do
  before(:each) do
    @stalking = assign(:stalking, FactoryGirl.create(:stalking))
  end

  it "renders attributes in <p>" do
    render

    response.should render_template('show')
    edit_link = edit_stalking_path(@stalking)
    rendered.should match(/#{edit_link}/)
  end
end
