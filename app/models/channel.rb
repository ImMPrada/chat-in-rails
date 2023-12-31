class Channel < ApplicationRecord
  include Destinationable

  BASIC_CHANNEL_NAME = 'general'.freeze

  before_create :add_avatar_url
  after_destroy :broadcast_destruction
  after_create_commit :broadcast_new_channel_created
  after_update_commit :broadcast_update_to

  validates :name,
            presence: true,
            format: {
              with: /\A[a-zA-Z0-9_\-\s]*\z/,
              message: 'only allows letters, numbers, spaces, underscores, and dashes'
            }

  belongs_to :workspace

  has_many :channel_users, dependent: :destroy
  has_many :users, through: :channel_users
  has_many :messages, as: :classifiable, dependent: :destroy

  def destination_path
    :workspace_channel_messages_path
  end

  private

  def add_avatar_url
    self.avatar_url = "https://ui-avatars.com/api/?background=3c393f&color=fff&rounded=false&bold=true&name=#{CGI.escape(name)}"
  end

  def broadcast_destruction
    broadcast_remove_to(
      [workspace, 'workspace'],
      target: "channel_#{id}_card"
    )
  end

  def broadcast_new_channel_created
    broadcast_append_to(
      [workspace, 'workspace'],
      target: 'channels_list',
      partial: 'partials/workspace_channel/channel_card',
      locals: {
        channel: self,
        workspace:
      }
    )
  end

  def broadcast_update_to
    broadcast_replace_to(
      [workspace, 'workspace'],
      target: "channel_#{id}_card",
      partial: 'partials/workspace_channel/channel_card',
      locals: {
        channel: self,
        workspace:
      }
    )
  end
end
