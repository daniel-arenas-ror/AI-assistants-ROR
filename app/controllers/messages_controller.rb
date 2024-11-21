class MessagesController < ApplicationController
  def create
    p " params "
    p params
    p " ************** "

    #ActionCable.server.broadcast "ai_message_channel", { some: "time out" }

    ActionCable.server.broadcast "ai_message_channel", { someq: "someq" }

    render json: {}, status: :accepted
  end
end
