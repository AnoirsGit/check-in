class WorkingTimesController < ApplicationController
  before_action :set_working_time, only: %i[ show edit update destroy ]
  before_action :set_time, only: %i[ create update ]

  # GET /working_times or /working_times.json
  def start_timer
    category = Category.find_or_create_by(title: 'Card')
    current_user.working_times.create(started_at: DateTime.now,
                                      bio: 'Recorded by card', category_id: category.id)
    redirect_to root_path, notice: 'Entrance was successfully recorded!'
  end

  def end_timer
    current_user.working_times.last.update(ended_at: DateTime.now)
    redirect_to root_path, notice: ' Exit was successfully recorded!'
  end

  def index
    if params[:week]
      @working_times = current_user.working_times.where('ended_at >= ?',  DateTime.now - 1.week)
      @total = current_user.get_total_time(@working_times)
    elsif params[:month]
      @working_times = current_user.working_times.where('ended_at >= ?',  DateTime.now - 1.month)
      @total = current_user.get_total_time(@working_times)
    else
      @working_times = current_user.working_times
      @total = current_user.get_total_time(@working_times)
    end

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


    if @started_at > @ended_at
      redirect_to new_working_time_path, alert: 'Your time frames are invalid!'
    else
      @working_time = WorkingTime.new(working_time_params)
      @working_time.started_at = @started_at
      @working_time.ended_at = @ended_at

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
  end

  # PATCH/PUT /working_times/1 or /working_times/1.json
  def update
    @working_time.started_at = @started_at
    @working_time.ended_at = @ended_at
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

  def set_time
    @started_at =DateTime.civil(params[:started_at][:year].to_i, params[:started_at][:month].to_i, params[:started_at][:day].to_i,
                               params[:started_at][:hour].to_i,params[:started_at][:minute].to_i, params[:started_at][:second].to_i)

    @ended_at =DateTime.civil(params[:ended_at][:year].to_i, params[:ended_at][:month].to_i, params[:ended_at][:day].to_i,
                             params[:ended_at][:hour].to_i,params[:ended_at][:minute].to_i, params[:ended_at][:second].to_i)

  end

    # Only allow a list of trusted parameters through.
    def working_time_params
      params.require(:working_time).permit(:bio, :category_id).merge(user_id: current_user.id)
    end
end
