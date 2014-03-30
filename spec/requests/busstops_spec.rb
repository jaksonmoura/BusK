require 'spec_helper'

describe "Busstops" do
  before { login }

  describe ".new" do
    it "saves the busstop correctly" do
      visit new_busstop_path
      bs = FactoryGirl.build(:busstop)
      kind = {0 => 'Parada', 1 => 'Estação'}
      select kind[bs.kind], from: "busstop_kind"
      page.find("#busstop_lat").set bs.lat
      page.find("#busstop_lng").set bs.lng
      expect { click_button 'Salvar' }.to change(Busstop, :count).by(1)
      current_path.should eq(busstops_path)
      page.should have_content("salva")
    end

    it "doesn't save the busstop" do
      visit new_busstop_path
      page.find("#busstop_lat").set ""
      page.find("#busstop_lng").set ""
      click_button "Salvar"
      page.should have_content("errado")
    end
  end

  describe ".update" do
    bs = FactoryGirl.create(:busstop)
    it "updates the busstop" do
      visit edit_busstop_path(bs)
      page.find('#busstop_lat').set bs.lng
      page.find('#busstop_lng').set bs.lat
      click_button 'Atualiza'
      current_path.should eq(busstops_path)
    end

    it "doesn't update" do
      visit edit_busstop_path(bs)
      page.find('#busstop_lat').set ''
      page.find('#busstop_lng').set ''
      click_button 'Atualiza'
      page.should have_content("err")
    end
  end

  describe ".delete" do
    bs = FactoryGirl.create(:busstop)
    it "deletes successfully" do
      visit busstops_path
      expect { first('.actions').click_on('Remover') }.to change(Busstop, :count).by(-1)
      current_path.should eq(busstops_path)
    end
  end

end
