class FeedController < ApplicationController
  allow_unauthenticated only: :show

  def show
  end
end
