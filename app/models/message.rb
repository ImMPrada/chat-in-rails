class Message < ApplicationRecord
  belongs_to :classifiable, polymorphic: true, optional: false
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', optional: false
  belongs_to :responded_message, class_name: 'Message', optional: true

  has_many :responded_messages,
           class_name: 'Message',
           foreign_key: 'responded_message_id'

  validates :content, presence: true
end
