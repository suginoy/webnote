require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new_user'" do
    it "should be successful" do
      get 'new_user'
      response.should be_success
    end
  end

end
