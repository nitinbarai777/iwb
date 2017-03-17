class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_user_groups, inverse_of: :user
  accepts_nested_attributes_for :user_user_groups, allow_destroy: true

  has_many :user_groups, :through => :user_user_groups

  validates :first_name, :presence => true, :length => {:maximum => 50}
  validates :last_name, :length => {:maximum => 50, :allow_blank => true}
  validates :manager_id, :length => {:maximum => 50, :allow_blank => true}
  validates :email, :presence => true, :length => {:maximum => 50}

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

end
