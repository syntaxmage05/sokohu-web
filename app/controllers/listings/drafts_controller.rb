# frozen_string_literal: true

class Listings::DraftsController < ApplicationController
  skip_authorization only: :create
  before_action :load_listing, only: :update

  def create
    @listing = Listing.new(
      listing_params.with_defaults(
        creator: Current.user,
        organization: Current.organization,
        status: :draft
      )
    )

    if @listing.save
      flash[:success] = t(".success")
      redirect_to listing_path(@listing),
        status: :see_other
    else
      render "listings/new", status: :unprocessable_entity
    end
  end

  def update
    @listing.assign_attributes(
      listing_params.with_defaults(
        status: :draft
      )
    )

    if @listing.save
      flash[:success] = t(".success")
      redirect_to listing_path(@listing),
        status: :see_other
    else
      render "listings/edit", status: :unprocessable_entity
    end
  end

  private

    def listing_params
      params.expect(listing: Listing.permitted_attributes)
    end

    def authorizable_resource
      @listing = Listing.find(params[:listing_id])
    end
end
