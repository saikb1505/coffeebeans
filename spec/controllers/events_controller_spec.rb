require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'POST #create_event_a' do
    it 'creates Event A', :vcr do
      post :create_event_a
      expect(response).to redirect_to(root_path)
      # with a valid API key we can add mode tests to verify the functionality
      expect(flash[:notice]).to eq('Event A created')
    end
  end

  describe 'POST #create_event_b' do
    it 'creates Event B and sends email', :vcr do
      post :create_event_b
      expect(response).to redirect_to(root_path)
      # with a valid API key we can add mode tests to verify the functionality
      expect(flash[:notice]).to eq('Event B created and email sent')
    end
  end
end