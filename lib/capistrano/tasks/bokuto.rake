require 'rake'
require 'json'
require 'capistrano/bokuto'

namespace :bokuto do

  def opsworks
    Capistrano::Bokuto::Connection.new(\
      :access_key_id => fetch(:access_key_id),
      :secret_access_key => fetch(:secret_access_key)
    )
  end

  def deployment_ids
    {
      :stack_id => fetch(:stack_id),
      :app_id => fetch(:app_id)
    }
  end

  def custom_json
    app_name = fetch(:app_name)
    branch = fetch(:branch, :master)
    custom_args = fetch(:custom_deploy_args, {})

    args = Hash.new
    args[:deploy] = Hash.new
    args[:deploy][app_name] =
    {
      scm: {
        revision: branch
      }
    }

    args.deep_merge!(custom_args)
    return args.to_json
  end
  def start_deploy command_args={}
    ids = deployment_ids
    deploy_opts = {
      :command => {
        :name => 'deploy', 
        :args => command_args
      },
      :comment => 'Bokken Deploy',
      :custom_json => custom_json
    }
    opts = ids.merge(deploy_opts)

    opsworks.deploy(opts)
  end

  task :default do
    puts start_deploy
  end

  task :custom_json do
    puts custom_json
  end
  desc "Add command arg migrate=true to deploy (Rails app specific?)"
  task :migrate do
    puts start_deploy({"migrate"=>["true"]})
  end
  task :migrations => :migrate

  desc "Checks your app_id for validity"
  task :check do
    puts "app_id #{fetch(:app_id)} is valid" if opsworks.check(deployment_ids)
  end

  desc "Displays deployment history for app_id"
  task :history do
    puts opsworks.history deployment_ids[:app_id]
  end

  task :verify, :deployment_id do |task, args|
    puts opsworks.verify args[:deployment_id]
  end
end

after 'deploy:check', 'bokuto:check'
after 'deploy:starting', 'bokuto:default'

desc "Deploy to opsworks"
task :bokuto => ["bokuto:default"]