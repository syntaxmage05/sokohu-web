# frozen_string_literal: true

class FeedController < ApplicationController
  allow_unauthenticated only: :show

  def show
    @pagy, @listings = pagy(Listing.feed, page: params[:page] || 1)

    # For turbo frame requests, render just the items partial
    if turbo_frame_request?
      render partial: "feed_page", locals: { listings: @listings, page: params[:page].to_i, pagy: @pagy }
    end
  end
end
