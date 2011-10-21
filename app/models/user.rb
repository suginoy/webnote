class User < ActiveRecord::Base
 #has_many  :memopages, :dependent => true # Rails 1.x ?
  has_many  :memopages, :dependent => :destroy
  has_many  :comments,  :dependent => :destroy

  validates :name,  :uniqueness => true,
                    :format => { :with => /^[0-9a-zA-Z]+$/ }
  validates :password,  :presence => true,
                        :confirmation => true

  def self.authenticate(attr)
    find_by_name_and_password(attr[:name], attr[:password])
  end
end
