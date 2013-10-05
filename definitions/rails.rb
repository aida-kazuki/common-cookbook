#
# Cookbook Name:: common
# Definition:: rails
#
# Copyright 2013, Naoya Nakazawa
#
# All rights reserved - Do Not Redistribute
#

define :common_rails_database, :user => "", :confs => {} do
  database_content = ""
  params[:confs].each do |rails_env, conf|
    database_content << "#{rails_env}:\n"
    conf.each do |key, val|
      database_content << "  #{key}: #{val}\n"
    end
    # for Rails 4.0
    # http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/ConnectionPool.html
    database_content << <<-EOH
  pool: 10
  checkout_timeout: 5
  reaping_frequency: nil
  dead_connection_timeout: 5
EOH
  end

  file "#{params[:name]}/config/database.yml" do
    content database_content
    owner params[:user]
    group params[:user]
    mode 0600
    action :create
  end
end