class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.text :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :folders, [:user_id, :created_at]
  end
end
