require "spec_helper"
RSpec.describe ApplicationController do
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

  #   context "given no name in the sesion" do
  #     it "returns a status 200 OK"
  #     it "has an input for a name"
  #   end

  #   context "given a name in the session" do
  #     it "returns a status 200 OK"
  #     it "has no input for a name"
  #     it "greets you by name"
  #   end

  end
end
