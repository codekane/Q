require 'spec_helper'

RSpec.describe ApplicationController do
  describe "sockets", type: :feature, js: true do
    before :each do
      visit '/'
    end

    it "cycles connect button to disconnect upon click" do
      fill_in(:"socket-name", :with => "Scald")
      click_button("Connect")

      expect(page).to have_button("Disconnect")
      expect(page).to have_no_button("Connect")
    end

    it "cycles connect button back to connect with two clicks" do
      fill_in(:"socket-name", :with => "Scald")
      click_button("Connect")
      click_button("Disconnect")

      expect(page).to have_button("Connect")
      expect(page).to have_no_button("Disconnect")
    end

  end
end
