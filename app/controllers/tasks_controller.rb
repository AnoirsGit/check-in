class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :add_user, :start_timer, :end_timer]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user, :start_timer, :end_timer]
  
  def add_user
    @user = User.find_by(email: params[:email])
    @task.users.push(@user)
    redirect_to projects_path
  end

  def start_timer
    WorkingTime.start(current_user, @task)
    redirect_to project_task_path(@project, @task)
  end

  def end_timer
    WorkingTime.end(current_user, @task)
    redirect_to project_task_path(@project, @task)
  end
  
  def edit
  end

  def show
    @total_today = to_time(WorkingTime.today_total_with_ticking(current_user, @task))
    @total_worked = to_time(WorkingTime.total(current_user, @task))
  end

  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        add_users
        format.html { redirect_to @task.project, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @task = Task.new(task_params.merge(users: users))
    @task.project = Project.find(params[:project_id])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def to_hours(seconds)
    (seconds.to_i / 3600).floor(2)
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :status, :project_id, :time_to_complete)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = @task.project
  end

  def add_users
    params[:task][:users] = params[:task][:users].filter(&:present?)
    @task.update(users: params[:task][:users].map { |id| User.find(id) })
  end

  def to_time(seconds)
    Time.at(seconds).utc.strftime("%H:%M")
  end
end
