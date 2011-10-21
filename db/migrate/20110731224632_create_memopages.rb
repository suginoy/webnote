class CreateMemopages < ActiveRecord::Migration
  def change
    create_table :memopages do |t|
      t.string :title, :null => false
      t.text :content

      t.timestamps
    end
  end
end
