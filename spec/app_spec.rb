require './app'
require 'spec_helper'
require 'pry'
# set :environment, :test

describe 'Repeat app' do
  # describe "root" do
  #   specify "returns some json" do
  #     get "/"
  #     expect(last_response.status).to eq(200)
  #     expect(JSON.parse(last_response.body)["order"]["id"]).to eq(2785488044191)
  #   end
  # end
  #
  # describe "orders" do
  #   specify "returns numbers of orders places" do
  #     get "/orders"
  #     expect(last_response.status).to eq(200)
  #     expect(JSON.parse(last_response.body)["orders"].length).to eq(50)
  #   end
  # end

  describe "/stats" do
    specify "returns stats" do
      get "/stats"
      expect(last_response.status).to eq(200)
      response = JSON.parse(last_response.body)
      expect(response["ltvs"]["4105388654751"]["total"]).to eq(17.0)
      expect(response["ltvs"]["4105388654751"]["customer"]["first_name"]).to eq("leaf")
      # expect(response["product_count"]).to eq({})

      expect(response["orders_placed"]).to eq(50)
    end
  end
end
