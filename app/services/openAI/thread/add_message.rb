module OpenAI
  module Thread
    class AddMessage < OpenAI::Base
      
      attr_reader :message, :thread_id

      def initialize(
        thread_id:
      )
        @thread_id = thread_id
        @message = Message.find_by_thread_id(thread_id)

        super(assistant_id: @message.assistant_id)
      end

      def process(text_message)
        p "add message"
        p " text_message #{text_message}"
        p " @thread_id #{@thread_id}"

        message = client.messages.create(
          thread_id: @thread_id,
          parameters: {
            role: "user",
            content: text_message
          }
         )

        p "run thread"
        run = client.runs.create(
          thread_id: @thread_id,
          parameters: {
            assistant_id: @assistant.code
          }
        )
        
        run_id = run['id']

        while true do
          response = client.runs.retrieve(id: run_id, thread_id: @thread_id)
          status = response['status']

          p " status "
          p status
          p " ***** "

          case status
          when 'queued', 'in_progress', 'cancelling'
            puts 'Sleeping'
            sleep 1 # Wait one second and poll again

            ActionCable.server.broadcast "ai_message_channel_#{@thread_id}", { action: 'startTyping' }
          when 'completed'

            ActionCable.server.broadcast "ai_message_channel_#{@thread_id}", { action: 'stopTyping' }
            sleep rand(1..3)

            messages = client.messages.list(thread_id: thread_id, parameters: { order: 'asc' })
            @message.update!(messages: messages)

            ActionCable.server.broadcast "ai_message_channel_#{@thread_id}", { action: 'updateMessages', messages: @message.messages }

            break # Exit loop and report result to user
          when 'requires_action'
            # Handle tool calls (see below)
          when 'cancelled', 'failed', 'expired'
            puts response['last_error'].inspect
            break # or `exit`
          else
            puts "Unknown status response: #{status}"
          end
        end
      end
    end
  end
end
