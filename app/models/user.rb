class User < ApplicationRecord
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

  private

  def add_avatar_url
    self.avatar_url = "https://api.dicebear.com/6.x/bottts/svg?seed=#{self.username}"
  end
end
