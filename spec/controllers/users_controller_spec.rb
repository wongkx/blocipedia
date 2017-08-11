require 'rails_helper'
require_relative "../support/controller_macros"

RSpec.describe UsersController, type: :controller do
    # let(:new_user_attributes) do
    #     {
    #         name: 'BlocHead',
    #         email: 'blochead@bloc.io',
    #         password: 'blochead',
    #         password_confirmation: 'blochead'
    #     }
    # end
    
    describe "GET new" do
      login_admin

      it "should have a current_user" do
        # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
        expect(subject.current_user).to_not eq(nil)
      end
    
      it "should get index" do
        # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
        # the valid_session overrides the devise login. Remove the valid_session from your specs
        get 'index'
        response.should be_success
      end
    end
end
