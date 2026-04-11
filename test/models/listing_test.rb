require "test_helper"

class ListingTest < ActiveSupport::TestCase
  setup do
    @user = users(:jerry)
    @listing = listings(:jerry_listing_1)
  end

  test "downcase tags before saving" do
    @listing.tags = [ "Electronics", "Tools" ]
    @listing.save

    assert_equal [ "electronics", "tools" ], @listing.tags
  end
end
