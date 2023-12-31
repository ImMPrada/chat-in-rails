class User < ApplicationRecord
  include Destinationable

  before_create :add_avatar_url

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-zA-Z0-9_.-]*\z/,
              message: 'only allows letters, numbers, underscores, periods, and dashes'
            }

  has_many :workspace_users, dependent: :destroy
  has_many :workspaces, through: :workspace_users
  has_many :roles, through: :workspace_users
  has_many :channel_users, dependent: :destroy
  has_many :invitations, dependent: :destroy, foreign_key: :receiver_id

  def owner?(workspace)
    workspace_user = WorkspaceUser.find_by(user: self, workspace:)
    return false unless workspace_user

    workspace_user.role.owner?
  end

  def admin?(workspace)
    workspace_user = WorkspaceUser.find_by(user: self, workspace:)
    return false unless workspace_user

    workspace_user.role.admin? || workspace_user.role.owner?
  end

  def member?(workspace)
    workspace_user = WorkspaceUser.find_by(user: self, workspace:)
    return false unless workspace_user

    workspace_user.role.member? || workspace_user.role.admin? || workspace_user.role.owner?
  end

  def destination_path
    :workspace_user_messages_path
  end

  private

  def add_avatar_url
    self.avatar_url = "https://api.dicebear.com/6.x/bottts/svg?seed=#{CGI.escape(username)}"
  end
end
