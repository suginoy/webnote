class AddUserIdToMemopages < ActiveRecord::Migration
  def change
    add_column :memopages, :user_id, :integer, :null => false, :default => 0
    #if user = User.first
    #  Memopage.all.each do |page|
    #    page.update_attribute(:user_id, user.id)
    #  end 
    #end 
  end
end
