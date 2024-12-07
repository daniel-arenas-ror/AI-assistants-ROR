module OpenAI
  module AssistantAI
    class Create < OpenAI::Base
      def initialize(assistant_id: )
        super
      end

      def process
        response = @client.assistants.create(
          parameters: {
            model: @assistant.model,
            name: @assistant.name,
            description: @assistant.description,
            instructions: @assistant.prompt,
            tools: [
             { type: "file_search" },
             { type: "function",
               function: {
                 name: "make_order",
                 description: "Function to get information of customer",
                 parameters: {
                   type: "object",
                   properties: {
                     name: { type: "string", description: "nombre del cliente" },
                     phone: { type: "string", description: "telefono del cliente" },
                     address: { type: "string", description: "direccion del pedido" },
                     dish: { type: "string", description: "platos que debe de tener el pedido" },
                     extra_observation: { type: "string", description: "recomendaciones extras" }
                   },
                   additionalProperties: true,
                   required: [
                     "name",
                     "phone",
                     "address",
                     "dish"
                   ]
                 }
               }
             }
            ],
            tool_resources: {
             file_search: {
               vector_store_ids: []
             }
            },
            "metadata": { my_internal_version_id: "1.0.0" }
          }
        )

        @assistant.update!(code: response["id"])
      end
    end
  end
end
