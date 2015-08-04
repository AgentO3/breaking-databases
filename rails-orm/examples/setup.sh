#!bin/bash

apt-get update

apt-get install curl

curl -L https://get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm
rvm requirements

rvm install ruby
rvm use ruby --default
rvm rubygems current
gem install rails

apt-get install nodejs

apt-get install mysql-server
