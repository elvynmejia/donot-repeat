require 'sinatra/base'
require 'json'
require 'dotenv'
require 'shopify_api'

Dotenv.load('.env.development')

# should go on an initializer
ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@benton-dev.myshopify.com"
ShopifyAPI::Base.api_version = '2020-10'

class Repeat < Sinatra::Base

  before do
    content_type :json
  end

  get '/' do
    { order: ShopifyAPI::Order.find(:all).first }.to_json
  end
end

# Repeat.run!
