require './app'
require 'spec_helper'
require 'pry'
# set :environment, :test

describe 'Repeat app' do
  describe "/stats" do
    specify "number of orders places" do
      get "/stats"
      expect(last_response.status).to eq(200)
      response = JSON.parse(last_response.body)
      expect(response["orders_placed"]).to eq(89)
    end

    specify "calculates customer's total ltv" do
      get "/stats"
      expect(last_response.status).to eq(200)
      response = JSON.parse(last_response.body)
      expect(response["ltvs"]["4105388654751"]["total"]).to eq(17.0)
      expect(response["ltvs"]["4105388654751"]["customer"]["first_name"]).to eq("leaf")
    end

    specify "calculates product's total revenue" do
      get "/stats"
      expect(last_response.status).to eq(200)
      response = JSON.parse(last_response.body)
      expect(response["revenue_by_product"]["5764030038175"]["total"]).to eq(3.0)
      expect(response["revenue_by_product"]["5764030038175"]["line_item"]["name"]).to eq("long tree")
    end
  end
end
