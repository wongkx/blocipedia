require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(email:'blochead@bloc.io', password: 'password')}
  let(:my_wiki) {Wiki.create!(title:'My title', body:'my wiki body', user:user )}
  
  it {is_expected.to belong_to(:user)}
  
  describe "attributes" do
      it "has title and body attributes" do
          expect(my_wiki).to have_attributes(title: 'My title', body:'my wiki body')
      end
  end
end
