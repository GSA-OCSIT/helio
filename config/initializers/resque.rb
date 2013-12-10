Resque.redis = Redis.new
Resque.logger = Logger.new("#{Rails.root}/log/resque.log")