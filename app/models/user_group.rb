class UserGroup < ActiveRecord::Base

  has_many :user_user_groups, inverse_of: :user_group
  accepts_nested_attributes_for :user_user_groups, allow_destroy: true
  
  has_many :users, :through => :user_user_groups
  has_many :charts, inverse_of: :user_group

  validates :name, :presence => true, :length => {:maximum => 50}

end
