class User < ActiveRecord::Base

  rolify

  after_create :add_roles

  validates_uniqueness_of :email
  validates_uniqueness_of :uid
  belongs_to :agency
  after_create :add_roles
  has_many :subscriptions


  def has_gov_email?
    return %w{ .gov .mil .fed.us }.any? {|x| self.email.end_with?(x)}
  end

  def add_roles
    self.add_role :admin if User.count == 1 # make the first user an admin
    self.add_role :agency_admin if has_gov_email?
    self.add_role :user
  end

  def log_sign_in(ip)
    self.sign_in_count = self.sign_in_count+1
    self.last_sign_in_at = Time.zone.now
    self.current_sign_in_at = Time.zone.now
    self.current_sign_in_ip = ip
    self.last_sign_in_ip = ip
    self.save
  end

  def log_sign_out(ip)
    self.current_sign_in_ip = nil
    self.current_sign_in_at = nil
    self.save
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || auth['info']['email']
        user.email = auth['info']['email'] || ""
      end
      if auth['extra']
        user.gender = auth['extra']['raw_info']['gender'] || ""
        user.zip = auth['extra']['raw_info']['zip'] || ""
        user.is_parent = auth['extra']['raw_info']['is_parent'] || ""
      end
    end
  end
end

