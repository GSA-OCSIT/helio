class AlertType < ActiveRecord::Base
  belongs_to :agency
  has_many :alerts
  before_save :update_slug
  has_many :subscriptions
  has_many :users, :through => :subscriptions

  validates_uniqueness_of :slug, :scope => [:agency]

  def update_slug
  	self.slug = name.parameterize
  end

end
