require 'spec_helper'

describe "Welcomes" do
  describe ".index" do
    it "works!" do
      visit root_path
      click_on "Buscar"
      page.should have_content("Idas")
      page.should have_content("Voltas")
    end
  end
end
