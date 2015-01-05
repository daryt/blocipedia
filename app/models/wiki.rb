class Wiki < ActiveRecord::Base
  has_many :pages
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

end
