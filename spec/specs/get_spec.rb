require 'spec_helper'

RSpec.describe ApplicationController do

describe "GET '/'" do
    it "resolves successfully" do
      get "/"
      expect(last_response.status).to eq 200
    end
    it "has a button to launch the queue popup" do
      get "/"
      expect(last_response.body).to have_tag("button#launchQueue")
    end
  end

  describe "GET '/' :js", type: :feature, js: true do

    it "Embeds Ezcapechat" do
      visit '/'
      expect(page).to have_tag("div.ezcapechat_embed")
    end

    it "Pops up the YouTube Queue" do
      visit '/'

      queue = window_opened_by do
        click_button("Listen In")
      end

      within_window(queue) do
        expect(page).to have_current_path('/queue')
      end
    end

    it "Focuses the same window without creating a new one on additional clicks"
  end

  describe "GET /queue", type: :feature do
    before do
      visit '/queue'
    end

    it "asks who you are" do
      expect(page.body).to include("and you are?")
    end

    it "knows who you are" do
      fill_in(:name, :with => "Scald")
      click_button "Submit"

      expect(page).to have_text("Scald")
    end

    it "has a form for entering your name" do
      expect(page).to have_selector("form")
      expect(page).to have_field(:name)
    end
  end

  describe "GET '/queue' :js", type: :feature,  js: true do
    before do
      visit '/queue'
      fill_in(:name, :with => "Scald")
      click_button "Submit"
    end

    it "knows who I am" do
      expect(page).to have_text("Scald")
    end

    it "correctly toggles visibility of the search" do
      expect(page).to have_css('#queue-pop', :visible => false)
      click_button("Add Video")
      expect(page).to have_css('#queue-pop', :visible => true)
      click_button("Add Video")
      expect(page).to have_css('#queue-pop', :visible => false)
    end
  end
end
