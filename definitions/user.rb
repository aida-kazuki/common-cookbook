#
# Cookbook Name:: common
# Definition:: user
#
# Copyright 2013, Naoya Nakazawa
#
# All rights reserved - Do Not Redistribute
#

define :common_user, :password => "", :shell => "/bin/bash" do
  home_dir = "/home/#{params[:name]}"
  directory home_dir do
    owner params[:name]
    group params[:name]
    mode 0700
  end

  group params[:name] do
    action :create
  end

  user params[:name] do
    shell params[:shell]
    gid params[:name]
    home home_dir
    password params[:password]
    supports :manage_home => true
    action :create
  end
end