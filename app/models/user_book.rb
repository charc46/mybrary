class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :complete, -> { where(completed: true) }
  scope :not_complete, -> { where(completed: false) }
end
