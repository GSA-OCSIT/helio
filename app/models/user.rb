class User < ActiveRecord::Base

  rolify

  after_create :add_roles

  validates_uniqueness_of :email
  validates_uniqueness_of :uid
  # validates_presence_of :agency, :if => :has_gov_email?
  belongs_to :agency
  after_create :add_roles
  has_many :subscriptions


  def has_gov_email?
    return %w{ .gov .mil .fed.us }.any? {|x| self.email.end_with?(x)}
  end

  def add_roles
    add_role :admin if User.count == 1 # make the first user an admin
    add_role :agency_admin if has_gov_email?
    add_role :user
  end

  def log_sign_in(ip,auth)
    self.sign_in_count = self.sign_in_count+1
    self.last_sign_in_at, self.current_sign_in_at = Time.now, Time.now
    self.current_sign_in_ip, self.last_sign_in_ip = ip, ip
    self.token = auth['credentials']['token']
    save
  end

  def log_sign_out(ip)
    self.current_sign_in_ip, self.current_sign_in_at = nil, nil
    self.save
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth['credentials']['token']
      if auth['info']
        user.name = auth['info']['name'] || auth['info']['email']
        user.email = auth['info']['email'] || ""
      end
      if auth['extra']
        user.gender = auth['extra']['raw_info']['gender'] || ""
        user.zip = auth['extra']['raw_info']['zip'] || ""
        user.is_parent = auth['extra']['raw_info']['is_parent'] || ""
      end
      if agency = Agency.find_by_email_suffix(user.email.split("@").last)
        user.agency = agency
      end
    end
  end
end

