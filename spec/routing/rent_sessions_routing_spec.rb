require "rails_helper"

RSpec.describe RentSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rent_sessions").to route_to("rent_sessions#index")
    end

    it "routes to #new" do
      expect(get: "/rent_sessions/new").to route_to("rent_sessions#new")
    end

    it "routes to #show" do
      expect(get: "/rent_sessions/1").to route_to("rent_sessions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/rent_sessions/1/edit").to route_to("rent_sessions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/rent_sessions").to route_to("rent_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/rent_sessions/1").to route_to("rent_sessions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/rent_sessions/1").to route_to("rent_sessions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/rent_sessions/1").to route_to("rent_sessions#destroy", id: "1")
    end
  end
end
