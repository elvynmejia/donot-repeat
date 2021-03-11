require './app'
require 'spec_helper'

# set :environment, :test

describe 'Repeat app' do
  describe "root" do
    specify "returns some json" do
      get "/"
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)["order"]["id"]).to eq(2785488044191)
    end
  end

  describe "orders" do
    specify "returns numbers of orders places" do
      get '/orders'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)["orders"].length).to eq(50)
    end
  end
end
