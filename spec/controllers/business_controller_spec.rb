require 'rails_helper'

RSpec.describe BusinessController, type: :controller do

  describe "#activate" do

    subject { post :activate, :id => "1", :ref_link => ' test ' }

    it "Should retirect to landing selection page" do
     allow(controller).to receive(:current_user).and_return(User.find(6) || User.find(1))  
     expect(subject).to redirect_to('/landings/?business_id=1')

    end
  end

end