require 'rails_helper'

describe EventsController do
  describe 'GET #new' do
    context 'when not logged in user accessing' do
      before { get :new }

      it 'redirect toppage' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when logged in user accessing' do
      before do
        user = FactoryGirl.create(:user)
        session[:user_id] = user.id
        get :new
      end

      it 'response to 200 of status code' do
        expect(response.status).to eq(200)
      end

      it 'new event object is stored in @event' do
        expect(assigns(:event)).to be_a_new(Event)
      end

      it 'render new template' do
        expect(response).to render_template :new
      end
    end
  end
end
