# frozen_string_literal: true

class SavedListingsController < ApplicationController
  before_action :load_listing, except: :show

  def show
    drop_breadcrumb t(".title")

    @pagy, @listings = pagy(Current.user.saved_listings, page: params[:page] || 1)

    # For turbo frame requests, render just the items partial
    if turbo_frame_request?
      render partial: "saved_listings_page", locals: { listings: @listings, page: params[:page].to_i, pagy: @pagy }
    else
      render :show
    end
  end

  def create
    Current.user.saved_listings << @listing
  end

  def destroy
    Current.user.saved_listings.destroy(@listing)
  end

  private

    def default_render
      render turbo_stream: turbo_stream.update(
        "save_button",
        partial: "listings/save_button",
        locals: {
          listing: @listing
        }
      )
    end

    def load_listing
      @listing = Listing.find(params[:listing_id])
    end
end
