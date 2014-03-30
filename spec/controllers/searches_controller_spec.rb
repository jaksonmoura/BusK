require 'spec_helper'

describe SearchesController do
  describe ".index" do
    before do
      @g = FactoryGirl.create(:going)
      @r = FactoryGirl.create(:return)
    end
    it "find results" do
      get :index, "index" => { "cur_b" => "103 N", "cur_av" => "NS 02", "des_b" => "105 S", "des_av" => "NS 03" }
      @goings = Going.search("103 N NS 02", "105 S NS 03")
      @returns = Return.search("203 N NS 02", "405 S NS 03")
      expect(@goings).to_not be_empty
      expect(@returns).to_not be_empty
    end

    it "doesn't find results" do
      @goings = Going.search(" ", " ")
      @returns = Return.search(" ", " ")
      expect(@goings).to eq([])
      expect(@returns).to eq([])
      # get :index, "index" => { "cur_b" => "", "cur_av" => "", "des_b" => "", "des_av" => "" }
    end

    it "find surroundings" do
      @g_sur = Going.search_surroundings("203 N", "405 S")
      @r_sur = Return.search_surroundings("103 N","105 S")
      expect(@g_sur).to_not be_empty
      expect(@r_sur).to_not be_empty
    end

    it "doesn't find surroundings" do
      @g_sur = Going.search_surroundings("103 N", "105 S")
      @r_sur = Return.search_surroundings("205 S", "405 S")
      expect(@g_sur).to be_empty
      expect(@r_sur).to be_empty
    end

    after do
      @g.destroy!
      @r.destroy!
    end
  end
end
