require 'test/unit'

begin
  require 'rubygems'
  require 'redgreen'
  require 'leftright'
rescue LoadError
end

require 'rack/test'
require 'mocha'
require 'spec/mini'

ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'boot'
require 'helpers/http'
require 'helpers/itunes'
require 'helpers/utility'

include Play
include Play::HTTPHelpers
include Play::ItunesHelpers
include Play::UtilityHelpers
include Rack::Test::Methods