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

  # TODO: MUST should consider order status, pagination and rate limiting
  get '/stats' do
    orders = ShopifyAPI::Order.find(:all)

    # 2. What is the LTV (lifetime value) of our customers? That is, how much revenue does a customer generate?
    customer_id_to_orders = orders.group_by do |order|
      order.attributes["customer"].attributes["id"]
    end

    ltvs = customer_id_to_orders.each_with_object({}) do |(customer_id, orders), memo|
      memo[customer_id] = {
        total: orders.inject(0) {|sum, order| sum + order.attributes["total_price"]&.to_f },
        customer: orders.detect do |order|
          break order.attributes["customer"] if order.attributes["customer"].attributes["id"] === customer_id
        end
      }
    end

    {
      ltvs: ltvs,
      orders_placed: ShopifyAPI::Order.find(:all).length,
      product_count: [] #products_id_to_order.flatten,
    }.to_json
  end
end

# Repeat.run!
