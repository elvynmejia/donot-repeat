require 'sinatra/base'
require 'json'
require 'dotenv'
require 'shopify_api'
require 'pry'
require 'sinatra/cross_origin'


Dotenv.load('.env.development')

# should go on an initializer
ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@benton-dev.myshopify.com"
ShopifyAPI::Base.api_version = '2020-10'



class Repeat < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end


  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    content_type :json
  end

  # TODO: MUST consider order status, pagination, rate limiting, data store, data consistency and policy etc
  get '/stats' do

    orders = ShopifyAPI::Order.find(:all)

    # 2. What is the LTV (lifetime value) of our customers? That is, how much revenue does a customer generate?
    customer_id_to_orders = orders.group_by do |order|
      order.attributes["customer"].attributes["id"]
    end

    ltvs = customer_id_to_orders.each_with_object({}) do |(customer_id, orders), memo|
      total = orders.inject(0) {|sum, order| sum + order.attributes["total_price"]&.to_f }
      customer = orders.detect do |order|
        break order.attributes["customer"] if order.attributes["customer"].attributes["id"] === customer_id
      end

      memo[customer_id] = {
        total: total,
        customer: customer
      }
    end

    # 3. What products generate the most revenue?
    products_id_to_order = orders.group_by do |order|
      order.attributes["line_items"].group_by { |ln| ln.attributes["product_id"] }
    end

    revenue_by_product = products_id_to_order.flatten.each_with_object({}) do |product, memo|
      if product.respond_to?(:keys)
        product_id = product.keys[0]
        line_items = product.values[0]

        total = line_items.inject(0) {|sum, ln| sum + ln.attributes["price"]&.to_f }

        line_item = line_items.detect do |ln|
          ln.attributes["product_id"] === product_id
        end

        memo[product_id] = {
          total: total,
          line_item: line_item
        }
      end
      memo
    end
    #
    # #NOTE ShopifyAPI::Order.count differs from ShopifyAPI::Order.find(:all)
    # # so we would have to paginate ShopifyAPI::Order.find(:all) to get the remaining orders
    # {
    #   ltvs: ltvs,
    #   orders_placed: ShopifyAPI::Order.count,
    #   revenue_by_product: revenue_by_product,
    # }.to_json

    {
      ltvs: "ltvs",
      orders_placed: "ShopifyAPI::Order.count",
      revenue_by_product: "revenue_by_product",
    }.to_json
  end
end

# Repeat.run!
