require 'spec_helper'

describe BusstopsController do
  before do
   @user = FactoryGirl.create(:user)
    sign_in @user
   @busstops = Busstop.all
   @busstops.each { |bs| bs.destroy! }
 end

  it "shows all bus stops" do
    busstop = FactoryGirl.create(:busstop)
    get :index, {}
    assigns(:busstops).should eq([busstop])
  end

  it "create new bus stop" do
    busstop = FactoryGirl.build(:busstop)
    busstop.lat.should_not be_nil
    busstop.lng.should_not be_nil
    busstop.kind.should_not be_nil
    busstop.save
  end

end
