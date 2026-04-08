module MessageVerifier
  extend ActiveSupport::Concern

  class_methods do
    def message_verifier
      Rails.application.message_verifier(name)
    end
  end

  private

  def message_verifier
    self.class.message_verifier
  end
end
