require 'spec_helper'

describe ReturnsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    FactoryGirl.create(:line)
  end

  describe "GET show" do
    it "assigns the requested rtn as @return" do
      rtn = FactoryGirl.create(:return)
      get :show, {line_id: rtn.line_id, :id => rtn.to_param}
      assigns(:return).should eq(rtn)
      bs = FactoryGirl.create(:busstop)
      busstops = [bs.lat.to_f, bs.lng.to_f, bs.kind.to_i]
      busstops.should_not be_nil
    end
  end

  describe "GET new" do
    before do
      @goings = Going.all
      @goings.each { |g| g.destroy! }
    end
    it "assigns a new rtn as @return coming from new going" do
      rtn = FactoryGirl.build(:return)
      g = FactoryGirl.create(:going)
      get :new, {line_id: 1, g_id: g.id}
      assigns(:return).should be_a_new(Return)
    end

    it "assigns a new rtn as @return" do
      rtn = FactoryGirl.build(:return)
      get :new, {line_id: rtn.line_id}
      assigns(:return).should be_a_new(Return)
    end
  end

  describe "GET edit" do
    it "assigns the requested rtn as @return" do
      rtn = FactoryGirl.create(:return)
      get :edit, {line_id: rtn.line_id, :id => rtn.to_param}
      assigns(:return).should eq(rtn)
    end
  end

  describe "POST create" do
    before(:all) do
      @return = FactoryGirl.build(:return)
    end
    describe "with valid params" do
      it "creates a new Return" do
        expect {
          post :create, {line_id: @return.line_id, :return => @return.attributes}
        }.to change(Return, :count).by(1)
      end

      it "assigns a newly created rtn as @return" do
        post :create, {line_id: @return.line_id, :return => @return.attributes}
        assigns(:return).should be_a(Return)
        assigns(:return).should be_persisted
      end

      it "redirects to new returns" do
        post :create, {line_id: @return.line_id,  :return => @return.attributes }
        response.should redirect_to(line_path(@return.line_id))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rtn as @return" do
        # Trigger the behavior that occurs when invalid params are submitted
        Return.any_instance.stub(:save).and_return(false)
        post :create, {line_id: @return.line_id, :return => { "days_of_week" => "invalid value" }}
        assigns(:return).should be_a_new(Return)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Return.any_instance.stub(:save).and_return(false)
        post :create, {line_id: @return.line_id, :return => { "days_of_week" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:all) do
      @return = FactoryGirl.create(:return)
    end
    describe "with valid params" do
      it "updates the requested rtn" do
        Return.any_instance.should_receive(:update).with({ "days_of_week" => "MyString" })
        put :update, {line_id: @return.line_id, :id => @return.to_param, :return => { "days_of_week" => "MyString" }}
      end

      it "assigns the requested rtn as @return" do
        put :update, {line_id: @return.line_id, :id => @return.to_param, :return => { "days_of_week" => "MyString" }}
        assigns(:return).should eq(@return)
      end

      it "redirects to the rtn" do
        put :update, {line_id: @return.line_id, :id => @return.to_param, :return => { "days_of_week" => "MyString" }}
        response.should redirect_to(line_return_path(@return.line_id, @return.to_param))
      end
    end

    describe "with invalid params" do
      it "assigns the rtn as @return" do
        # Trigger the behavior that occurs when invalid params are submitted
        Return.any_instance.stub(:save).and_return(false)
        put :update, {line_id: @return.line_id, :id => @return.to_param, :return => { "days_of_week" => "invalid value" }}
        assigns(:return).should eq(@return)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Return.any_instance.stub(:save).and_return(false)
        put :update, {line_id: @return.line_id, :id => @return.to_param, :return => { "days_of_week" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:all) do
      @return = FactoryGirl.create(:return)
    end
    it "destroys the requested rtn" do
      expect {
        delete :destroy, {line_id: @return.line_id, :id => @return.to_param}
      }.to change(Return, :count).by(-1)
    end

    it "redirects to the lines list" do
      delete :destroy, {line_id: @return.line_id, :id => @return.to_param}
      response.should redirect_to(line_path(@return.line_id))
    end
  end

end
