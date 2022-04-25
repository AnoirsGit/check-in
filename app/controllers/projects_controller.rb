class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user]
  before_action :user_projects, only: [:index]
  before_action :admin?, only: [:new, :edit, :update, :destroy, :add_user]


  def index
    @all_users = User.all
  end

  def add_user
    @user = User.find_by(email: params[:email])
    @project.users.push(@user)
    redirect_to projects_path
  end

  def show
    project_users
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.users.push(current_user)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_projects
    @projects = current_user.projects
  end

  def project_params
    params.require(:project).permit(:title, :description, :deadline, :status, :color)
  end
  
  def set_project
    @project = Project.find(params[:id])
  end

  def project_users
    @users = @project.users
  end

  def admin?
    current_user.admin?
  end

end
