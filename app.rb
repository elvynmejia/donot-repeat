require 'sinatra/base'
require 'json'
require 'dotenv'

Dotenv.load('.env.development')

class Repeat < Sinatra::Base

  before do
    content_type :json
  end

  get '/' do
    # puts "============= ENV['SHOPIFY_API_KEY'] => #{ENV['SHOPIFY_API_KEY']} ============"
    { root: "Wake me Up" }.to_json
  end
end

# Repeat.run!
