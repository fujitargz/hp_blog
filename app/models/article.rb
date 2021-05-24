class Article < ApplicationRecord
	acts_as_taggable_on :tags
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	has_rich_text :content
	validates :user_id, presence: true
	validates :subject, presence: true
	validates :content, presence: true
end
