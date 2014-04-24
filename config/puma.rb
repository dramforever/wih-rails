#!/usr/bin/env puma

environment "production"
basedir = "/var/www/app/wih-rails"
worker = 4 
threads 4,48

bind  "unix:///var/www/app/wih-rails/tmp/puma/wih-rails.sock"
#bind "tcp://115.28.175.41:8080"
pidfile  "#{basedir}/tmp/puma/pid"
state_path "#{basedir}/tmp/puma/state"
preload_app!
activate_control_app
