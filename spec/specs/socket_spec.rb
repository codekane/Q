require 'spec_helper'

RSpec.describe ApplicationController do
  describe "sockets", type: :feature, js: true do
    before :each do
      visit '/'
      fill_in(:"socket-name", :with => "Scald")
    end

    it "cycles connect button to disconnect upon click" do
      expect(page).to have_button("Connect")
      expect(page).to have_no_button("Disconnect")
      click_button("Connect")

      expect(page).to have_button("Disconnect")
      expect(page).to have_no_button("Connect")
    end

    it "cycles connect button back to connect with two clicks" do
      click_button("Connect")
      click_button("Disconnect")

      expect(page).to have_button("Connect")
      expect(page).to have_no_button("Disconnect")
    end

    it "hides name input upon connection, then shows upon disconnection" do
      click_button("Connect")
      expect(page).not_to have_selector("#socket-name")

      click_button("Disconnect")
      expect(page).to have_selector("#socket-name")
    end

  end
end
