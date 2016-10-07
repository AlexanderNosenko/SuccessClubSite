require 'rails_helper'

RSpec.describe BusinessController, type: :controller do

  describe "POST #activate" do

    subject { post :activate, :id => "redex" }

    it "Should retirect to landing selection page" do
    	
     expect(subject).to redirect_to('/landings/?business_id=redex')

    end
  end

end