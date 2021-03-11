require 'sinatra'
require 'json'

before do
  content_type :json
end

get '/' do
   { root: "Wake me Up" }.to_json
end
