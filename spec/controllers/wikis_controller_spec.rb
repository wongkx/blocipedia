require 'rails_helper'

RSpec.describe WikisController, type: :controller do
    let(:my_wiki) { Wiki.create!(title: 'My Wiki Title', body: 'My Wiki Body') }
    describe 'GET index' do
        it 'returns http success' do
            get :index
            expect(response).to have_http_status(:success)
        end
        
        it 'assigns [my_wiki] to @wikis' do
            get :index
            expect(assigns(:wikis)).to eq([my_wiki])
        end
    end
    
    describe 'GET show' do
        it 'returns http success' do
            get :show, {id: my_wiki.id}
            expect(response).to have_http_status(:success)
        end
        
        it 'renders the #show view' do
            get :show, {id: my_wiki.id}
            expect(response).to render_template(:show)
        end
        
        it 'assigns my_wiki to @wiki' do
            get :show, {id: my_wiki.id}
            expect(assigns(:wiki)).to eq(my_wiki)
        end
    end
    
    describe 'GET new' do
        it 'returns http success' do
            get :new
            expect(response).to have_http_status(:success)
        end
    end
    
    describe 'POST create' do
        it 'increases the number of Wikis by 1' do
            expect{post :create, wiki: {title: 'another wiki', body: 'another wiki body'}}.to change(Wiki,:count).by(1)
        end
    end
    
    describe 'GET edit' do
        it 'returns http success' do
            get :edit, {id: my_wiki.id}
            expect(response).to have_http_status(:success)
        end
        
        it 'returns http redirect' do
            get :edit, {id: my_wiki.id}
            expect(response).to have_http_status(:success)
        end
        
        it "renders the edit view" do
            get :edit, {id: my_wiki.id}
            expect(response).to render_template :edit
        end
    end
    
    describe 'DELETE destroy' do
        it 'returns http redirect' do
            delete :destroy, {id: my_wiki.id}
            expect(response).to have_http_status(:redirect)
        end
    end
end
