require 'spec_helper'

describe "Lines" do
  before { login }

  describe ".index" do
    it "creates a new line" do
      l = FactoryGirl.build(:line)
      visit lines_path
      page.should have_content("Nova linha")
      page.find('#line_name').set l.name
      expect{ click_button 'Salva' }.to change(Line, :count).by(1)
      current_path.should eq(new_line_going_path(Line.last.id))
    end

  end

end
