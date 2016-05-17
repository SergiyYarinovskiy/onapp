require 'spec_helper'

describe Admin::TicketsController, type: :controller do
  before do
    user = create(:admin_user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_admin_user).and_return(user)
  end

  let!(:ticket) { create(:ticket) }

  describe "GET 'index'" do
    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    context 'HTML view' do
      it "renders ticket's code" do
        get :index
        expect(response.body) =~ /#{ticket.code}/
      end
    end

    context 'JSON view' do
      it 'renders ticket as json' do
        request.accept = 'application/json'
        get :index
        expect(response.body).to eql [ticket].to_json
      end
    end
  end

  describe "GET 'search'" do
    it 'returns correct ticket' do
      get :search, query: ticket.code
      expect(response.body) =~ /#{ticket.code}/
    end
  end

  describe "PUT 'update'" do
    it 'updates admin user' do
      new_admin_user = create(:new_admin_user)
      put :update, id: ticket.id, ticket: { admin_user_id: new_admin_user.id }
      expect(ticket.reload.admin_user).to eql new_admin_user
    end
  end
end
