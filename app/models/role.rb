class Role < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-z]*\z/,
              message: 'only allows a-z letterss'
            }

  def admin?
    name == 'admin'
  end

  def owner?
    name == 'owner'
  end

  def member?
    name == 'member'
  end
end
