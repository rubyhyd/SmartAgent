require 'spec_helper'

describe PagesController, type: :controller do


  describe "GUEST -- no sign in" do

    it "should render :strat when get :start" do
      get :start
      expect(response).to render_template :start
    end

    it "should redirect to signin_url when get :index" do
      get :index
      expect(response).to redirect_to signin_url 
    end

    it "should redirect to signin_url when get :myapps" do
      get :myapps
      expect(response).to redirect_to signin_url 
    end

    it "should redirect to signin_url when get :createapp" do
      get :createapp
      expect(response).to redirect_to signin_url 
    end

    it "should redirect to signin_url when get :resources" do
      get :resources
      expect(response).to redirect_to signin_url 
    end

    it "should redirect to signin_url when get :developer" do
      get :developer
      expect(response).to redirect_to signin_url 
    end
  end

  describe "USER -- sign in" do

    let(:user) { create :user_with_apps }
    before do
      session[:user_id] = user.id
    end

    it "should redirect_to index when get :start" do
      get :start
      expect(response).to redirect_to pages_index_url
    end

    context "GET #index" do

      it "assgins user apps to @apps" do
        get :index
        expect(assigns(:apps)).to eq user.apps
      end

      it "should render :index when get :index" do
        get :index
        expect(response).to render_template :index
      end

    end

    
  end
end






