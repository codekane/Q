require "spec_helper"
RSpec.describe ApplicationController do
  def app
    ApplicationController
  end

  describe "GET index" do
    it "resolves successfully" do
      get "/"
      expect(last_response.status).to eq 200
    end
    it "has a button to launch the queue popup" do
      get "/"
      expect(last_response.body).to have_tag("button#launchQueue")
    end
  end

  describe "GET queue" do
    it "resolves successfully" do
      get "/queue"
      expect(last_response.status).to eq 200
    end
  end
end
