class SearchesController < ApplicationController
  def index
    @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
    @blocks = Block.all
    @avenues = Avenue.all
      @goings = Going.search("#{params[:cur_b]} #{params[:cur_av]}", "#{params[:des_b]} #{params[:des_av]}")
      @returns = Return.search("#{params[:cur_b]} #{params[:cur_av]}", "#{params[:des_b]} #{params[:des_av]}")
    # If the search returns [], it should do a new search using only the Blocks
    # At the same time look for surrounding blocks

    # Looks for surroundings
    if !params[:cur_b].empty?
      if @goings == []
        @s_goings = Going.search_surroundings("#{params[:cur_b]}", "#{params[:des_b]}")
      end
      if @returns == []
        @s_returns = Return.search_surroundings("#{params[:cur_b]}", "#{params[:des_b]}")
      end
    else
      @s_goings = []
      @s_returns = []
    end
    # At the same block but in differents Av.
    # @b_goings = Going.search("#{params[:cur_b]}", "#{params[:des_b]}")
    # @b_returns = Return.search("#{params[:cur_b]}", "#{params[:des_b]}")
  end
end