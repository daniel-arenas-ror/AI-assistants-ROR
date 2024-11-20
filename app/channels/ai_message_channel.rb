class AiMessageChannel < ApplicationCable::Channel
  def subscribed
    p " subscribed "
    # stream_from "some_channel"
  end

  def unsubscribed
    p " unsubscribed "
    # Any cleanup needed when channel is unsubscribed
  end
end
