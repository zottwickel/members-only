class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true

  validates :subject, presence: true,
  										length: { maximum: 25 }

  validates :body, 		presence: true,
  								 		length: { maximum: 140 }
end
