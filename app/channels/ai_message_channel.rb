class AiMessageChannel < ApplicationCable::Channel
  def subscribed
    p " subscribed "
    p params
    p " *********** "
    stream_from "ai_message_channel" ## here just configurate the channel to send the updates

    #ActionCable.server.broadcast "ai_message_channel", { someq: "someq" }
  end

  def unsubscribed
    p " unsubscribed "
    # Any cleanup needed when channel is unsubscribed

    stop_all_streams
  end
end
