require 'spec_helper'

RSpec.describe ApplicationController do

  describe "GET '/queue' - Who are you" do
    it "asks who you are" do
      visit '/queue'
      expect(page.body).to include("and you are?")
    end

    it "has a form for entering your name" do
      visit '/queue'
      expect(page).to have_selector("form")
      expect(page).to have_field(:name)
    end

  end
  describe "POST '/queue' - User Greeting" do
    it "knows who you are" do
      visit '/queue'

      fill_in(:name, :with => "Scald")
      click_button "Submit"

      expect(page).to have_text("Scald")
    end
  end
end
