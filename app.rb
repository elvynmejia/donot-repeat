require 'sinatra/base'
require 'json'

class Repeat < Sinatra::Base

  before do
    content_type :json
  end

  get '/' do
    { root: "Wake me Up" }.to_json
  end
end

# Repeat.run!
