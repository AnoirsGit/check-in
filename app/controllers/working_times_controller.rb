class WorkingTimesController < ApplicationController
  before_action :set_working_time, only: %i[ show edit update destroy ]

  # GET /working_times or /working_times.json
  def index
    @working_times = WorkingTime.where()
  end

  # GET /working_times/1 or /working_times/1.json
  def show
  end

  # GET /working_times/new
  def new
    @working_time = WorkingTime.new
  end

  # GET /working_times/1/edit
  def edit
  end

  # POST /working_times or /working_times.json
  def create
    @working_time = WorkingTime.new(working_time_params)

    respond_to do |format|
      if @working_time.save
        format.html { redirect_to @working_time, notice: "Working time was successfully created." }
        format.json { render :show, status: :created, location: @working_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @working_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /working_times/1 or /working_times/1.json
  def update
    respond_to do |format|
      if @working_time.update(working_time_params)
        format.html { redirect_to @working_time, notice: "Working time was successfully updated." }
        format.json { render :show, status: :ok, location: @working_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @working_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /working_times/1 or /working_times/1.json
  def destroy
    @working_time.destroy
    respond_to do |format|
      format.html { redirect_to working_times_url, notice: "Working time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_working_time
      @working_time = WorkingTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def working_time_params
      params.require(:working_time).permit(:started_at, :ended_at, :bio, :user_id)
    end
end
