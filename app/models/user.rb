class User < ActiveRecord::Base
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, 
  #        :recoverable, :rememberable, :trackable, :validatable
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, 
  #        :recoverable, :rememberable, :trackable, :validatable
  rolify

  after_create :add_roles


  def has_gov_email?
    return %w{ .gov .mil .fed.us }.any? {|x| self.email.end_with?(x)}
  end

  def add_roles
    self.add_role :admin if User.count == 1 # make the first user an admin

    self.add_role :agency if self.has_gov_email?
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end
end



class User < ActiveRecord::Base
  has_one :profile

  rolify

  validates_presence_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :uid

  after_create :add_roles

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.email = auth['info']['email'] || ""
         user.name = auth['info']['name'] || user.email
      end
    end
  end

end
