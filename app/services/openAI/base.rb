module OpenAI
  class Base
    attr_reader :client, :enterpise, :assistant

    def initialize(assistant_id: )
      @assistant = Assistant.find(assistant_id)
      @enterpise = assistant.enterprise

      p " enterpise "
      p enterpise
      p "****"
      @client = OpenAI::Client.new(
        log_errors: true,
        access_token: enterpise.ai_api_key
      )
    end
  end
end
