class Workspace < ApplicationRecord
  before_create :add_avatar_url

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9_\-\s]*\z/,
              message: 'only allows letters, numbers'
            }

  has_many :workspace_users, dependent: :destroy
  has_many :users, through: :workspace_users
  has_many :workspace_channels, dependent: :destroy

  private

  def add_avatar_url
    self.avatar_url = "https://ui-avatars.com/api/?background=3c393f&color=fff&rounded=false&bold=true&name=#{CGI.escape(name)}"
  end
end
