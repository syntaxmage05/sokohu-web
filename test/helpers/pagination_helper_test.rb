require "test_helper"

class PaginationHelperTest < ActionView::TestCase
  setup do
    @turbo_native_app = false
  end

  test "don't show paginator in native apps" do
    @turbo_native_app = true
    assert_not show_paginator?
  end

  test "don't show paginator when there's just one page" do
    @pagy = Struct.new(:pages).new(1)
    assert_not show_paginator?
  end

  test "show paginator when there's more than one page" do
    @pagy = Struct.new(:pages).new(2)
    assert show_paginator?
  end

  private

  def turbo_native_app?
    @turbo_native_app
  end
end