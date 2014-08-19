require 'spec_helper'

describe UsersController, type: :controller do
 
  describe "get #new" do
    before do
      get :new
    end

    it "assigns a new user" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "should render :new" do
      expect(response).to render_template :new
    end

  end 

end
