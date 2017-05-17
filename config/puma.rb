
workers 1

# Min and Max threads per worker
threads 1, 6
# Specifies the `port` that Puma will listen on to receive requests, default is 3000.

application_path = "/var/www/policy_pro"
# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "production" }

bind "unix://#{application_path}/tmp/sockets/puma.sock"
worker_timeout 60

preload_app!

