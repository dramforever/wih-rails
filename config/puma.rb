#!/usr/bin/env puma

environment "production"
basedir = "/var/www/wih-rails"
worker = 1
threads 4,48

bind  "unix:///var/www/wih-rails/tmp/puma/wih-rails.sock"
#bind "tcp://115.28.175.41:8080"
pidfile  "#{basedir}/tmp/puma/pid"
state_path "#{basedir}/tmp/puma/state"
preload_app!
activate_control_app
