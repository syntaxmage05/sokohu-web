# frozen_string_literal: true

class Feed::SearchesController < ApplicationController
  allow_unauthenticated

  rescue_from ActionController::ParameterMissing do
    redirect_to root_path, status: :see_other
  end

  def show
    @pagy, @listings = pagy(
      Listing.feed.search(search_params[:query])
    )

    render "feed/show"
  end

  private

    def search_params
      params.expect(listings_search: [:query])
    end
end
