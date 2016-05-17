class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :folder
  acts_as_taggable
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 256 }
  VALID_URL_REGEX = URI::regexp(%w(http https))
  validates :url, presence: true, length: { maximum: 256 },
                  format: { with: VALID_URL_REGEX }
  validates :folder_id, presence: true
end
