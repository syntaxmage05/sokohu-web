# frozen_string_literal: true

class MyListingsController < ApplicationController
  def show
    @pagy, @listings = pagy(Current.organization.listings, page: params[:page] || 1)

    # For turbo frame requests, render just the items partial
    if turbo_frame_request?
      render partial: "my_listings_page", locals: { listings: @listings, page: params[:page].to_i, pagy: @pagy }
    end
  end
end
