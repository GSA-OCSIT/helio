<img src="http://presidential-innovation-fellows.github.io/mygov/images/design/h1.png" />
Project Codename: Helio
=========

Government notifications.. simplified.

Learn and sign up for important government alerts in one central location. Manage delivery of your notifications via [MyUSA](https://my.usa.gov).

Created by the [Presidential Innovation Fellows](http://www.whitehouse.gov/innovationfellows).


## How To Get Started
  - Clone repo (`git clone git@github.com:GSA-OCSIT/helio.git`)
  - Install the bundle (`bundle install`)
  - Rename application.yml.example (`cp application.example.yml application.yml`)
  - Register your application with [MyUSA](http://my.usa.gov) (Redirect URI: [host]/auth/myusa/callback)
  - Fire up rails! (`rails s`)

Dependencies:
  - Redis
	


## Diagnostics

Recipes:
[“apps4”, “controllers”, “core”, “email”, “extras”, “frontend”, “gems”, “git”, “init”, “models”, “prelaunch”, “railsapps”, “readme”, “routes”, “saas”, “setup”, “testing”, “views”]

Preferences:
{:git=>true, :apps4=>"none", :dev_webserver=>"thin", :prod_webserver=>"thin", :database=>"sqlite", :templates=>"slim", :unit_test=>"rspec", :integration=>"rspec-capybara", :continuous_testing=>"none", :fixtures=>"factory_girl", :frontend=>"bootstrap3", :email=>"gmail", :authentication=>"omniauth", :omniauth_provider=>"myusa", :authorization=>"cancan", :form_builder=>"simple_form", :starter_app=>"users_app", :rvmrc=>true, :quiet_assets=>true, :local_env_file=>true, :better_errors=>true, :github=>true}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


License
--

MIT

*Free Software, Hell Yeah!*
