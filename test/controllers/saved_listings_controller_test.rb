# frozen_string_literal: true

require "test_helper"

class SavedListingsControllerTest < ActionDispatch::IntegrationTest
  test "cannot save an ad created by oneself" do
      @listing = listings(:auto_listing_1_jerry)
      post listing_saved_listings_path(@listing)
      assert_response :forbidden
      assert_not @user.saved_listings.exists?(@listing.id)
    end
end
