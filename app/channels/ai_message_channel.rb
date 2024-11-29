class AiMessageChannel < ApplicationCable::Channel
  def subscribed
    assistant_id = params[:assistant_id]
    thread_id    = params[:thread_id]

    assistant = Assistant.find_by_code(params[:assistant_id])
    messages = assistant.messages.find_by_thread_id(thread_id).messages

    stream_from "ai_message_channel_#{thread_id}"
    ActionCable.server.broadcast "ai_message_channel_#{thread_id}", { action: 'updateMessages', messages: messages }
  end

  def unsubscribed
    stop_all_streams
  end
end
