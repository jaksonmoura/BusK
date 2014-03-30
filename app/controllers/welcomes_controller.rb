class WelcomesController < ApplicationController
  layout 'welcome'
  def index
    @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
    @blocks = Block.all
    @avenues = Avenue.all
    # if params[:cur_b] != nil
      @goings = Going.search("#{params[:cur_b]} #{params[:cur_av]}", "#{params[:des_b]} #{params[:des_av]}")
      @returns = Return.search("#{params[:cur_b]} #{params[:cur_av]}", "#{params[:des_b]} #{params[:des_av]}")
    # end
  end
end
