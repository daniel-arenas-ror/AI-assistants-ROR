module OpenAI
  module Thread
    class Create < OpenAI::Base

      def initialize(
        assistant_id: 
      )
        super
      end

      def process
        thread = @client.threads.create
        assistant.messages.create!(
          thread_id: thread["id"],
          messages: []
        )

        thread["id"]
      end
    end
  end
end
