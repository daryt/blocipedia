class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, through: :collaborations  
  after_initialize :init

  def role?(base_role)
    role == base_role.to_s
  end

  def admin?
      role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end
  
  def init
    self.role ||= 'standard'
  end

  def upgrade
    self.role = 'premium'
  end
  
end
