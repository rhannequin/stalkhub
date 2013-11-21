require 'spec_helper'

describe StalkingsController do

  let(:new_stalking) { FactoryGirl.build(:stalking).attributes }

  before(:all) do
    @user = FactoryGirl.create(:github_user)
  end

  before(:all) do
    @stalking = FactoryGirl.create(:stalking, user: @user)
  end

  before(:all) do
    @valid_session = { user_id: @user.id }
  end

  describe "GET index" do
    it "assigns all stalkings as @stalkings" do
      get :index, {}, @valid_session
      assigns(:stalkings).should eq([@stalking])
    end
  end

  describe "GET show" do
    it "assigns the requested stalking as @stalking" do
      get :show, {id: @stalking.to_param}, @valid_session
      assigns(:stalking).should eq(@stalking)
    end
  end

  describe "GET new" do
    it "assigns a new stalking as @stalking" do
      get :new, {}, @valid_session
      assigns(:stalking).should be_a_new(Stalking)
    end
  end

  describe "GET edit" do
    it "assigns the requested stalking as @stalking" do
      get :edit, {id: @stalking.to_param}, @valid_session
      assigns(:stalking).should eq(@stalking)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Stalking" do
        expect {
          post :create, {stalking: new_stalking}, @valid_session
        }.to change(Stalking, :count).by(1)
      end

      it "assigns a newly created stalking as @stalking" do
        post :create, {stalking: new_stalking}, @valid_session
        assigns(:stalking).should be_a(Stalking)
        assigns(:stalking).should be_persisted
      end

      it "redirects to the created stalking" do
        post :create, {stalking: new_stalking}, @valid_session
        response.should redirect_to(Stalking.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved stalking as @stalking" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stalking.any_instance.stub(:save).and_return(false)
        post :create, {stalking: { owner: "invalid value" }}, @valid_session
        assigns(:stalking).should be_a_new(Stalking)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stalking.any_instance.stub(:save).and_return(false)
        post :create, {stalking: { owner: "invalid value" }}, @valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested stalking" do
        put :update, {id: @stalking.to_param, stalking: { "owner" => "MyString" }}, @valid_session
      end

      it "assigns the requested stalking as @stalking" do
        put :update, {id: @stalking.to_param, stalking: new_stalking}, @valid_session
        assigns(:stalking).should eq(@stalking)
      end

      it "redirects to the stalking" do
        put :update, {id: @stalking.to_param, stalking: new_stalking}, @valid_session
        response.should redirect_to(@stalking)
      end
    end

    describe "with invalid params" do
      it "assigns the stalking as @stalking" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stalking.any_instance.stub(:save).and_return(false)
        put :update, {id: @stalking.to_param, stalking: new_stalking}, @valid_session
        assigns(:stalking).should eq(@stalking)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stalking.any_instance.stub(:save).and_return(false)
        put :update, {id: @stalking.to_param, stalking: new_stalking}, @valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested stalking" do
      expect {
        delete :destroy, {id: @stalking.to_param}, @valid_session
      }.to change(Stalking, :count).by(-1)
    end

    it "redirects to the stalkings list" do
      delete :destroy, {id: @stalking.to_param}, @valid_session
      response.should redirect_to(stalkings_url)
    end
  end

end
