require 'spec_helper'

RSpec.describe ApplicationController do
  describe "Search", type: :feature, js: true do
    before(:each) do
      visit '/queue'
      fill_in(:name, :with => "Scald")
      click_button("Submit")
      click_button("Add Video")
    end

    it "informs me of the numbers of the search results" do
      fill_in(:search, :with => "cats")
      click_button("Search")

      expect(page).to have_text("50")
      expect(page).to have_text("1000000")
    end

    it "displays a max of 50 results, even after clicking the button twice" do
      fill_in(:search, :with => "cats")
      click_button("Search")

      list = find('#searchResults').all('div.search-card')
      expect(list.length).to eq 50

      click_button("Search")
      wait_for_ajax
      newlist = find('#searchResults').all('div.search-card')
      expect(newlist.length).to eq 50
    end

    it "does not show previous/next buttons until a search is performed"

    it "loads the next page of results when the next page button is pressed"
    it "loads the previous page of results when the previous page button is pressed"
    it "disables the previous page button if this is the first page of results"
    it "disables the next page button if this is the last page of results"
    it "does not hit the API more than once on hitting the next button, the previous button, and then the next button again"

  end


end
