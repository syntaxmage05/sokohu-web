class ListingsController < ApplicationController
  before_action :load_listing, expect: [:new, :create]
  allow_unauthenticated only: :show

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(
      listing_params.with_defaults(
        creator: Current.user,
        organization: Current.organization
      )
    )

    if @listing.save
      redirect_to listing_path(@listing), flash: { success: t(".success") },
        status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def listing_params
    params.expect(listing: [:title, :price])
  end

  def load_listing
    @listing = Listing.find(params[:id])
  end
end
