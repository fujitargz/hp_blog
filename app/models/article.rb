class Article < ApplicationRecord
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	has_rich_text :content
	has_many :tags, through: :article_tags
	has_many :article_tags, dependent: :destroy
	validates :user_id, presence: true
	validates :subject, presence: true
	validates :content, presence: true

	def save_tags(tags)
		current_tags = self.tags.pluck(:name) unless self.tags.nil?
		old_tags = current_tags - tags
		new_tags = tags - current_tags

		old_tags.each do |old_name|
			self.tags.delete Tag.find_by(name: old_name)
		end

		new_tags.each do |new_name|
			article_tag = Tag.find_or_create_by(name: new_name)
			self.tags << article_tag
		end
	end
end
