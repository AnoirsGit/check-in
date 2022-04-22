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
  end

  def edit 
  end

  def update
    users = []
    task_params[:users_emails].split(",").each do |email|
      user = User.where(email: email)
      users.push(user) if user.present?
    end
    update_params = task_params.permit(:title, :description, :status, :project_id, :deadline)

    respond_to do |format|
      if @task.update(update_params.merge(users: users))
        format.html { redirect_to @project, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    users = []
    task_params[:users_emails].split(",").each do |email|
      user = User.where(email: email)
      users.push(user) if user.present?
    end
    create_params = task_params.permit(:title, :description, :status, :project_id, :deadline)

    @task = Task.new(create_params.merge(users: users))
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
    params.require(:task).permit(:title, :description, :deadline, :status, :project_id, :users_emails, :users)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = @task.project
  end
end
