class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # Convert the database records to Noticed notification instances so we can use helper methods

  end



  private
  
  def set_project
    @project = Project.find(params[:id])
  end

end
