module V1
  class ThreadsController < ApplicationController
    def create
      assistant = Assistant.find_by_code(params[:assistant_id])
      thread_id = OpenAI::Thread::Create.new(assistant_id: assistant.id).process

      render json: {
        thread_id: thread_id,
      }, status: :accepted
    end

    private

    def thread_params
      params.permit(
        :assistant_id
      )
    end
  end
end
