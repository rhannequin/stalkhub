require "spec_helper"

describe StalkingsController do
  describe "routing" do

    it "routes to #index" do
      get("/stalkings").should route_to("stalkings#index")
    end

    it "routes to #new" do
      get("/stalkings/new").should route_to("stalkings#new")
    end

    it "routes to #show" do
      get("/stalkings/1").should route_to("stalkings#show", id: "1")
    end

    it "routes to #edit" do
      get("/stalkings/1/edit").should route_to("stalkings#edit", id: "1")
    end

    it "routes to #create" do
      post("/stalkings").should route_to("stalkings#create")
    end

    it "routes to #update" do
      put("/stalkings/1").should route_to("stalkings#update", id: "1")
    end

    it "routes to #destroy" do
      delete("/stalkings/1").should route_to("stalkings#destroy", id: "1")
    end

  end
end
