class MessagesController < ApplicationController
  def create
    Thread.new do
      add_message = OpenAI::Thread::AddMessage.new(thread_id: message_params[:thread_id])
      add_message.process(message_params[:text])
    end

    render json: {}, status: :accepted
  end

  private

  def message_params
    params.require(:message).permit(
      :thread_id,
      :text
    )
  end
end
