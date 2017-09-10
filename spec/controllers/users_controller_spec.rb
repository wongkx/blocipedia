require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    # let(:new_user_attributes) do
    #     {
    #         name: 'BlocHead',
    #         email: 'blochead@bloc.io',
    #         password: 'blochead',
    #         password_confirmation: 'blochead'
    #     }
    # end
    
    
    describe "POST downgrade" do
      let(:my_user) { User.create!(email:'test@blocipedia.com', password: 'password', role: 'premium') }
      
      it "should downgrade to standard" do
        post :downgrade, id: my_user.id
        expect(my_user.role).to eq('standard')
      end
    end
end
