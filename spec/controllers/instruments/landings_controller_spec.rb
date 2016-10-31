require 'rails_helper'

RSpec.describe Instruments::LandingsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      allow(controller).to receive(:current_user).and_return(User.find(6))  
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
