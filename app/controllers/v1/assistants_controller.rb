module V1
  class AssistantsController < ApplicationController
    def show
      assistant = Assistant.find_by_code(params[:assistant_id])

      render json: {
        assistant: assistant
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
