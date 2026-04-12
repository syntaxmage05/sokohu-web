// app/javascript/controllers/infinite_scroll_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    nextPage: Number,
    url: String,
    framePrefix: { type: String, default: "feed_page" },
    loading: { type: Boolean, default: false },
  };

  connect() {
    // Prevent multiple observers on same element
    if (this.observer) return;

    this.observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting && !this.loadingValue) {
          this.loadNextPage();
        }
      },
      { threshold: 0.1, rootMargin: "100px" },
    );

    this.observer.observe(this.element);
  }

  disconnect() {
    this.observer?.disconnect();
    this.observer = null;
  }

  loadNextPage() {
    if (this.loadingValue) return;

    this.loadingValue = true;

    // Disconnect observer to prevent multiple loads
    this.observer?.disconnect();

    // Create and insert the next frame
    const frame = document.createElement("turbo-frame");
    frame.id = `${this.framePrefixValue}_${this.nextPageValue}`;
    frame.setAttribute("target", "_top");
    frame.setAttribute("src", this.urlValue);

    // Handle frame load completion
    frame.addEventListener("turbo:frame-load", () => {
      this.loadingValue = false;
    });

    // Handle frame load error
    frame.addEventListener("turbo:frame-missing", () => {
      console.error("Failed to load frame:", this.urlValue);
      this.loadingValue = false;
      // Restore loading indicator on error
      this.element.style.display = "block";
    });

    // Replace the loading indicator with the new frame
    this.element.replaceWith(frame);
  }
}
