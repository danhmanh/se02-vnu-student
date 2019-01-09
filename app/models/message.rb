class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true

  after_create_commit :message_broadcast

  private

  def message_broadcast
    MessageBroadcastJob.perform_later(self)
  end
end
