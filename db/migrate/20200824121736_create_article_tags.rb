class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.integer :article_id
      t.integer :tag_id

      t.timestamps
    end
		add_index :article_tags, :article_id
		add_index :article_tags, :tag_id
		add_index :article_tags, [:article_id, :tag_id], unique: true
  end
end
