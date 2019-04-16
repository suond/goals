require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'Get #index' do
        it 'should render the user index template' do
            get :index
            expect(response).to render_template(:index)
        end        
    end

    describe 'get #show' do
        it 'should render the user show template with a given id' do
            user = create(:user)
            get :show, params: {id: user.id}
            expect(response).to render_template(:show)
        end
    end

    describe 'GET #new' do
        it 'should render the new template' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do
        context 'with invalid params' do
            it 'validates the presence of the user\'s email and password' do
                post :create, params: {
                    user: {
                        email: 'fake_email',
                        password: ''
                    }
                }
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end
            it 'validates the password is too short' do
                post :create, params: {
                    user: {
                        email: 'fake_email',
                        password: '12345'
                    }
                }
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end
        end
        context 'with valid params' do
            it "redirects user to user show on success" do
                post :create, params: {
                    user: {
                        email: 'fake_email',
                        password: '1234567'
                    }
                }
                expect(response).to redirect_to('/users')

            end
        end
    end
end
