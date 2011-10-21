class AddPublicToMemopages < ActiveRecord::Migration
  def change
    add_column :memopages, :public, :boolean, :default => false
  end
end
