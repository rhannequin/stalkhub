require 'spec_helper'

describe 'users/show' do
  before(:each) do
    @user = assign(:user, FactoryGirl.build(:user))
  end

  it 'renders error message in <p>' do
    render
    rendered.should match(/p/)
  end
end
