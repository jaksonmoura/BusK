require 'spec_helper'

describe GoingsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    FactoryGirl.create(:line)
  end

  describe "GET show" do
    it "assigns the requested going as @going" do
      going = FactoryGirl.create(:going)
      get :show, {line_id: going.line_id, :id => going.to_param}
      assigns(:going).should eq(going)
      bs = FactoryGirl.create(:busstop)
      busstops = [bs.lat.to_f, bs.lng.to_f, bs.kind.to_i]
      busstops.should_not be_nil
    end
  end

  describe "GET new" do
    it "assigns a new going as @going" do
      going = FactoryGirl.build(:going)
      get :new, {line_id: going.line_id}
      assigns(:going).should be_a_new(Going)
    end
  end

  describe "GET edit" do
    it "assigns the requested going as @going" do
      going = FactoryGirl.create(:going)
      get :edit, {line_id: going.line_id, :id => going.to_param}
      assigns(:going).should eq(going)
    end
  end

  describe "POST create" do
    before(:all) do
      @going = FactoryGirl.build(:going)
    end
    describe "with valid params" do
      it "creates a new Going" do
        expect {
          post :create, {line_id: @going.line_id, :going => @going.attributes}
        }.to change(Going, :count).by(1)
      end

      it "assigns a newly created going as @going" do
        post :create, {line_id: @going.line_id, :going => @going.attributes}
        assigns(:going).should be_a(Going)
        assigns(:going).should be_persisted
      end

      it "redirects to new returns" do
        post :create, {line_id: @going.line_id,  :going => @going.attributes }
        response.should redirect_to(new_line_return_path(@going.line_id, g_id: Going.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved going as @going" do
        # Trigger the behavior that occurs when invalid params are submitted
        Going.any_instance.stub(:save).and_return(false)
        post :create, {line_id: @going.line_id, :going => { "days_of_week" => "invalid value" }}
        assigns(:going).should be_a_new(Going)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Going.any_instance.stub(:save).and_return(false)
        post :create, {line_id: @going.line_id, :going => { "days_of_week" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:all) do
      @going = FactoryGirl.create(:going)
    end
    describe "with valid params" do
      it "updates the requested going" do
        Going.any_instance.should_receive(:update).with({ "days_of_week" => "MyString" })
        put :update, {line_id: @going.line_id, :id => @going.id, :going => { "days_of_week" => "MyString" }}
      end

      it "assigns the requested going as @going" do
        put :update, {line_id: @going.line_id, :id => @going.id, :going => { "days_of_week" => "MyString" }}
        assigns(:going).should eq(@going)
      end

      it "redirects to the going" do
        put :update, {line_id: @going.line_id, :id => @going.id, :going => { "days_of_week" => "MyString" }}
        response.should redirect_to(line_going_path(@going.line_id, @going.id))
      end
    end

    describe "with invalid params" do
      it "assigns the going as @going" do
        # Trigger the behavior that occurs when invalid params are submitted
        Going.any_instance.stub(:save).and_return(false)
        put :update, {line_id: @going.line_id, :id => @going.to_param, :going => { "days_of_week" => "invalid value" }}
        assigns(:going).should eq(@going)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Going.any_instance.stub(:save).and_return(false)
        put :update, {line_id: @going.line_id, :id => @going.to_param, :going => { "days_of_week" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:all) do
      @going = FactoryGirl.create(:going)
    end
    it "destroys the requested going" do
      expect {
        delete :destroy, {line_id: @going.line_id, :id => @going.to_param}
      }.to change(Going, :count).by(-1)
    end

    it "redirects to the goings list" do
      delete :destroy, {line_id: @going.line_id, :id => @going.to_param}
      response.should redirect_to(lines_path(@going.line_id))
    end
  end

end
