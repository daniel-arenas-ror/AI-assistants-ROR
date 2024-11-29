module V1
  class AssistantsController < ApplicationController
    def show
      assistant = Assistant.find_by_code(params[:id])

      render json: {
        assistant: assistant
      }, status: :accepted
    end
  end
end
