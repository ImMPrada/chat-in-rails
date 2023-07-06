class Role < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[a-z]*\z/,
              message: 'only allows a-z letterss'
            }
end
