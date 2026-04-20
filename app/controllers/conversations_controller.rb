# frozen_string_literal: true

class ConversationsController < ApplicationController
  skip_authorization only: :index
  before_action :set_conversation, only: :show
  def index
    @conversations = Conversation.current_organization.for_display
  end

  def show
    @message = @conversation.messages.build
  end

  private

    def set_conversation
      @conversation = Conversation.find(params[:id])
    end
end
