require './app'
require 'spec_helper'

# set :environment, :test

describe 'Repeat app' do
  describe "root" do
    specify "returns some json" do
      get '/'
      last_response.should be_ok
      expect(JSON.parse(last_response.body)["root"]).to eq("Wake me Up")
    end
  end
end
