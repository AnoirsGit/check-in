class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @owned_grants = Grant.where(owner: current_user.id)
    @gaved_grants = Grant.where(target: current_user.id)
  end

  def hours
  end


end
