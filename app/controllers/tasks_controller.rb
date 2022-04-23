class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :add_user ]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user]

  def show
    @task = Task.find(params[:id])
    @user_tasks = @task.user_tasks
  end

  def add_user
    @user = User.find_by(email: params[:email])
    @task.users.push(@user)
    redirect_to projects_path
  end

  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def edit 
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
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
        format.html { redirect_to @project, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :status, :project_id, :users)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = @task.project
  end
end
