class ReturnsController < ApplicationController
  before_action :set_return, only: [:show, :edit, :update, :destroy]
  before_action :set_line
  before_filter :authenticate_user!, except: [:show]

  # GET /returns/1
  # GET /returns/1.json
  def show
    @blocks_passed = @return.blocks_passed.split(",")
    @bs = Busstop.all
    @busstops = @bs.map { |b| [b.lat.to_f, b.lng.to_f, b.kind.to_i] }
    @start_time = @return.schedule.split(",")[0]
    @end_time = @return.schedule.split(",")[@return.schedule.split(",").length - 1]
  end

  # GET /returns/new
  def new
    if params[:g_id]
      @going = Going.find(params[:g_id])
      @return = Return.new(:blocks_passed => @going.blocks_passed, :days_of_week => @going.days_of_week)
    else
      @return = Return.new
    end
    @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
  end

  # GET /returns/1/edit
  def edit
    @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
  end

  # POST /returns
  # POST /returns.json
  def create
    @return = Return.new(return_params)

    respond_to do |format|
      if @return.save
        format.html { redirect_to @line, notice: 'Return was successfully created.' }
        format.json { render action: 'show', status: :created, location: @line }
      else
        format.html { render action: 'new' }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /returns/1
  # PATCH/PUT /returns/1.json
  def update
    respond_to do |format|
      if @return.update(return_params)
        format.html { redirect_to line_return_path(@return.line_id, @return), notice: 'Return was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /returns/1
  # DELETE /returns/1.json
  def destroy
    @return.destroy
    respond_to do |format|
      format.html { redirect_to line_path(@return.line_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return
      @return = Return.find(params[:id])
    end

    def set_line
      @line = Line.find(params[:line_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def return_params
      params.require(:return).permit(:start_location, :end_location, :waypoints, :blocks_passed, :downvotes, :line_id, :days_of_week, :frequency, :schedule)
    end
end
