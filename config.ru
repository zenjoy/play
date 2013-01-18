require File.expand_path(File.dirname(__FILE__) + '/app/play')
require File.expand_path(File.dirname(__FILE__) + '/app/api')
require 'sprockets'

assets = Sprockets::Environment.new
assets.append_path 'app/assets/css'
assets.append_path 'app/assets/javascripts'
assets.append_path 'app/assets/fonts'

map("/assets")   { run assets }

run Rack::URLMap.new \
  "/"    => Play::App.new,
  "/api" => Play::Api.new
