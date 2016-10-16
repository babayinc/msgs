require File.dirname(__FILE__) + '/app.rb'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe 'MSGS' do

  include Rack::Test::Methods

  it 'should load the home page' do
    get '/'
    last_response.should be_ok
  end
end