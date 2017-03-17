class Chart < ActiveRecord::Base

  belongs_to :user_group, inverse_of: :charts

  has_many :chart_users, inverse_of: :chart, dependent: :destroy
  accepts_nested_attributes_for :chart_users, allow_destroy: true

  has_many :users, through: :chart_users

  validates :user_group, :presence => true
  validates :name, :presence => true, :length => {:maximum => 50}

end
