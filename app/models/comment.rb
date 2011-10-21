class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :memopage

  validates :message, :presence => true
end
