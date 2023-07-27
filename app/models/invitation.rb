class Invitation < ApplicationRecord
  belongs_to :workspace
  belongs_to :receiver, class_name: 'User', optional: true

  validates :token, presence: true, uniqueness: true

  def active?
    active
  end
end
