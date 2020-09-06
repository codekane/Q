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

  describe "Homepage", type: :feature, js: true do

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

  describe "logging in with the queue", type: :feature,  js: true do
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

  describe "searching youTube videos", type: :feature, js: true do
    before do
      visit '/queue'
      fill_in(:name, :with => "Scald")
      click_button("Submit")
    end

    it "informs me of the numbers of the search results" do
      click_button("Add Video")
      fill_in(:search, :with => "cats")
      click_button("Search")

      expect(page).to have_text("50")
      expect(page).to have_text("1000000")
    end

    it "displays a max of 50 results, even after clicking the button twice"

    it "displays a next page button if there are more than 50 total results"
  end
end
