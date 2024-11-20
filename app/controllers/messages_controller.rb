class MessagesController < ApplicationController
  def create
    ActionCable.server.broadcast 'public_chat', "HOLL!!!"
  end
end
