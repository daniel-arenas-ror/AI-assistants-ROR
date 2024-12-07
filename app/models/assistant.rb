class Assistant < ApplicationRecord
  belongs_to :enterprise
  validates :name, presence: true

  has_many :messages

  after_create :sync_assistant

  def sync_assistant
    OpenAI::AssistantAI::Create.new(assistant_id: self.id).process
  end
end
