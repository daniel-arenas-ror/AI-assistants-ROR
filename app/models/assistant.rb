class Assistant < ApplicationRecord
  belongs_to :enterprise
  validates :name, presence: true

  has_many :messages
end
