require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    log_in @user
  end

  test "can create a listing" do
    assert_difference "Listing.count", 1 do
      post listings_path, params: {
        listing: {
          title: "New Test Listing",
          price: 150
        }
      }
    end

    assert_redirected_to listing_path(Listing.last)
  end

  test "error when creating an invalid listing" do
    assert_no_difference "Listing.count" do
      post listings_path, params: {
        listing: {
          title: "a",
          price: 300
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger"
  end

  test "can update a listing" do
    @listing = listings(:jerry_listing_1)
    new_title = "Updated Jerry Listing"

    patch listing_path(@listing), params: {
      listing: {
        title: new_title,
        price: @listing.price
      }
    }

    assert_redirected_to listing_path(@listing)
    assert_equal new_title, @listing.reload.title
  end

  test "error when updating a listing with invalid data" do
    @listing = listings(:jerry_listing_1)

    patch listing_path(@listing), params: {
      listing: {
        title: @listing.title,
        price: "NaN"
      }
    }

    assert_response :unprocessable_entity
  end

  test "can delete a listing" do
    @listing = listings(:jerry_listing_1)

    assert_difference "Listing.count", -1 do
      delete listing_path(@listing)
    end

    assert_redirected_to root_path
  end
end