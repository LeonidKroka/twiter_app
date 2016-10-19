require 'rails_helper'

describe RelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        post :create, xhr: true, params: {relationship: { followed_id: other_user.id }}
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      post :create, xhr: true, params: {relationship: { followed_id: other_user.id }}
      expect(response).to be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by(followed_id: other_user) }

    it "should decrement the Relationship count" do
      expect do
        delete :destroy, xhr: true, params: {id: relationship.id}
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      delete :destroy, xhr: true, params: {id: relationship.id}
      expect(response).to be_success
    end
  end
end
