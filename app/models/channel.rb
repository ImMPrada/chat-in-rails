class Channel < ApplicationRecord
  before_create :add_avatar_url

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
end
