require 'sinatra/base'
require 'json'
require 'dotenv'
require 'shopify_api'
require 'pry'

Dotenv.load('.env.development')

# should go on an initializer
ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@benton-dev.myshopify.com"
ShopifyAPI::Base.api_version = '2020-10'

class Repeat < Sinatra::Base

  before do
    content_type :json
  end

  # get '/' do
  #   { order: ShopifyAPI::Order.find(:all).first }.to_json
  # end
  #
  # # should consider status, pagination, rate limiting
  # get '/orders' do
  #   ltv = ShopifyAPI::Order.find(:all).inject(0) do |sum,x|
  #     sum + x.attributes["total_price"].to_f
  #   end
  #
  #   # binding.pry
  #
  #   { orders: ShopifyAPI::Order.find(:all).map(&:to_json) }.to_json
  # end

  get '/stats' do
    orders = ShopifyAPI::Order.find(:all)

    ltv = orders.inject(0) do |sum,order|
      sum + order.attributes["total_price"].to_f
    end

    {
      ltv: ltv,
      orders_placed: ShopifyAPI::Order.find(:all).length
    }.to_json
  end
end

# Repeat.run!
