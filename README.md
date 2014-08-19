# Bokuto

Bokuto - A bokken (木剣, bok(u), "wood", and ken, "sword") (or commonly as bokutō 木刀 in Japan) is a Japanese wooden sword used for training

A gem to help deploy rails applications to AWS OpsWorks. Its Japanese name is inspired from Heroku since the goal is to make Bokuto a capistrano library to make opsworks deploys as close to heroku as possible.

Credits: This project is inspired from and is developed over [hcliu/capistrano-opsworks](https://github.com/hcliu/capistrano-opsworks)

## Installation

Add this line to your application's Gemfile:

    gem 'bokuto', :git => 'https://github.com/surenm/bokuto.git'

And then execute:

    $ bundle

## Usage

If you haven't installed [Capistrano](https://github.com/capistrano/capistrano), do that and make sure you 

    $ bundle exec cap install

Require the gem in your Capfile (example taken from default generated Capfile)

```ruby
###########
# Capfile #
###########

# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/bokuto'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails/tree/master/assets
#   https://github.com/capistrano/rails/tree/master/migrations
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
```

In the appropriate stage deploy file, add your OpsWorks details
```ruby
#############################
# /config/deploy/production.rb #
#############################

set :stage, :production

set :access_key_id, '<aws_access_key_id>'
set :secret_access_key, '<aws_secret_access_key>'
set :stack_id, '<opsworks_stack_id>'
set :app_id, '<opsworks_app_id>'
set :opsworks_custom_json, '<opsworks_custom_json>'
set :app_name, '<opsworks_app_name>'

# You can pass a has of Custom Json for a opsworks deploy
# Can be anything from here http://docs.aws.amazon.com/opsworks/latest/userguide/attributes-json-deploy.html#attributes-json-deploy-app-scm
set :custom_deploy_args, {
  deploy: {
  }
}
```

Check the task list using

    $ bundle exec cap -T

Check if you are all set to deploy using bokuto.

    $ bundle exec cap production deploy:check

Deploy your app (you'll get a deployment_id back if it worked)

    $ bundle exec cap production deploy

Deploy your app at a specific git revision (say test)

    $ bundle exec cap production deploy -s branch=test

Deploy if your IAM credentials are properly set up: 
The following command should return your IAM user name if its properly setup

    $ bundle exec cap production bokuto:credentials

Check the history of your app deployments

    $ bundle exec cap production bokuto:history

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request