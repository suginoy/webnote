class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, :null => false
      t.references :memopage, :null => false
      t.text :message, :null => false

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :memopage_id
  end
end
