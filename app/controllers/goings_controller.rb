class GoingsController < ApplicationController
  before_action :set_going, only: [:show, :edit, :update, :destroy]
  before_action :set_line
  before_action :set_days, only: [:new, :edit]
  before_filter :authenticate_user!, except: [:show]

  # GET /goings/1
  # GET /goings/1.json
  def show
    @blocks_passed = @going.blocks_passed.split(",")
    @bs = Busstop.all
    @busstops = @bs.map { |b| [b.lat.to_f, b.lng.to_f, b.kind.to_i] }
    @start_time = @going.schedule.split(",")[0]
    @end_time = @going.schedule.split(",")[@going.schedule.split(",").length - 1]
  end

  # GET /goings/new
  def new
    @going = Going.new
  end

  # GET /goings/1/edit
  def edit
  end

  # POST /goings
  # POST /goings.json
  def create
    @going = Going.new(going_params)

    respond_to do |format|
      if @going.save
        format.html { redirect_to new_line_return_path(@going.line_id, :g_id => @going.id), notice: 'Going was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @going }
      else
        format.html { render action: 'new' }
        format.json { render json: @going.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goings/1
  # PATCH/PUT /goings/1.json
  def update
    respond_to do |format|
      if @going.update(going_params)
        format.html { redirect_to line_going_path(@going.line_id, @going), notice: 'Going was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @going.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goings/1
  # DELETE /goings/1.json
  def destroy
    @going.destroy
    respond_to do |format|
      format.html { redirect_to lines_path(@line) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_going
      @going = Going.find(params[:id])
    end

    def set_days
      @days = {"Dom" => "D", "Seg" => "S", "Ter" => "T", "Qua" => "Q", "Qui" => "Q", "Sex" => "S", "Sab" => "S"}
    end

    def set_line
      @line = Line.find(params[:line_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def going_params
      params.require(:going).permit(:start_location, :end_location, :waypoints, :blocks_passed, :downvotes, :line_id, :days_of_week, :frequency, :schedule)
    end
end
