require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
  before do
    @user = FactoryBot.create(:user)
    allow_any_instance_of(IterableService).to receive(:create_event).and_return(double(success?: true))
    allow_any_instance_of(IterableService).to receive(:send_email).and_return(double(success?: true))
  end

  describe 'POST #create_event_a' do
    context 'when event is successfully created' do
      it 'creates Event A', :vcr do
        post :create_event_a, params: { email: @user.email }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Event A created')
      end
    end

    context 'when event creation fails' do
      it 'handles failure' do
        allow_any_instance_of(IterableService).to receive(:create_event).and_return(double(success?: false))
        post :create_event_a, params: { email: @user.email }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Failed to create Event A')
      end
    end
  end

  describe 'POST #create_event_b' do
    context 'when event and email are successfully created' do
      it 'creates Event B and sends email', :vcr do
        post :create_event_b, params: { email: @user.email }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Event B created and email sent')
      end
    end

    context 'when event creation fails' do
      it 'handles failure' do
        allow_any_instance_of(IterableService).to receive(:create_event).and_return(double(success?: false))
        post :create_event_b, params: { email: @user.email }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Failed to create Event B')
      end
    end

    context 'when email sending fails' do
      it 'handles failure' do
        allow_any_instance_of(IterableService).to receive(:send_email).and_return(double(success?: false))
        post :create_event_b, params: { email: @user.email }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Event B created but failed to send email')
      end
    end
  end
end
