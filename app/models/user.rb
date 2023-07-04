class User < ApplicationRecord
  before_create :add_avatar_url
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  private

  def add_avatar_url
    self.avatar_url = "https://api.dicebear.com/6.x/bottts/svg?seed=#{self.username}"
  end
end
