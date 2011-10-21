class Memopage < ActiveRecord::Base
  belongs_to  :user
  has_many    :comments, :dependent => :destroy

  validates :title, :presence => true

  scope :self, lambda do |login_user_id|
    where "user_id = ?", login_user_id
  end
  scope :open, lambda do |login_user_id|
    where "user_id != ? and public = ?", login_user_id, true
  end
  scope :both, lambda do |login_user_id|
    where "user_id = ? or public = ?", login_user_id, true
  end

  scope  :title_or_content_matches, lambda do |q|
    where 'title like :q or content like :q', :q => "%#{q}%"
  end
 
  default_scope order('created_at DESC')
  paginates_per 10

end
