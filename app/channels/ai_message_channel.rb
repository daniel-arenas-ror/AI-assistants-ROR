class AiMessageChannel < ApplicationCable::Channel
  def subscribed
    thread_id = params[:thread_id]
    stream_from "ai_message_channel_#{thread_id}"

    messages = Message.find_by_thread_id(thread_id).messages
    ActionCable.server.broadcast "ai_message_channel_#{thread_id}", { action: 'updateMessages', messages: messages }
  end

  def unsubscribed
    stop_all_streams
  end
end
