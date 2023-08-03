class Workspace < ApplicationRecord
  before_create :add_avatar_url

  after_update_commit :broadcast_new_channel_created

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9_\-\s]*\z/,
              message: 'only allows letters, numbers'
            }

  has_many :workspace_users, dependent: :destroy
  has_many :users, through: :workspace_users
  has_many :channels, dependent: :destroy
  has_many :invitations, dependent: :destroy

  private

  def add_avatar_url
    self.avatar_url = "https://ui-avatars.com/api/?background=3c393f&color=fff&rounded=false&bold=true&name=#{CGI.escape(name)}"
  end

  def broadcast_new_channel_created
    puts 'tea'
  end
end
