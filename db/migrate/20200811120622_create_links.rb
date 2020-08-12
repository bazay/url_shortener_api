class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.text :url
      t.string :slug
      t.integer :usage_count, default: 0
      t.datetime :expires_at

      t.timestamps
    end
    add_index :links, :slug, unique: true
  end
end
