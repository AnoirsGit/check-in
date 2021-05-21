class GrantsController < ApplicationController
  def new
    @grant = Grant.new
  end

  def create
    code = params[:code]

    user = User.find_by(code: code)

    if !user.nil? || user != current_user
      grant = Grant.create!(owner: current_user.id, target: user.id)
      redirect_to user_path(current_user), notice: 'You received a new grant!'
    else
      redirect_to user_path(current_user), alert:  'The code you have entered is incorrect!'
    end
  end
end