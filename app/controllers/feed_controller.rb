class FeedController < ApplicationController
  allow_unauthenticated only: :show

  def show
    @pagy, @listings = pagy(Listing.feed)
  end
end
