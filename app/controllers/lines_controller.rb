class LinesController < ApplicationController
  before_action :set_line, only: [:show, :edit, :update, :destroy, :routes]
  before_filter :authenticate_user!, except: [:all_lines, :show]
  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
    @line = Line.new
  end

  def all_lines
    @lines = Line.all
    @lines_count = Line.distinct.count(:include => :goings) + Line.distinct.count(:include => :returns)
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @goings = @line.goings
    @returns = @line.returns
    @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
  end

  # GET /lines/1/edit
  def edit
    @going = @line.goings.new
    @return = @line.returns.new
  end

  def routes
    @going = @line.goings.new
    @return = @line.returns.new
  end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to new_line_going_path(@line), notice: 'Linha criada com sucesso.' }
        format.json { render action: 'edit', status: :created, location: @line }
      else
        format.html { render action: 'index' }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: 'Linha atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to lines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:name)
    end
end
