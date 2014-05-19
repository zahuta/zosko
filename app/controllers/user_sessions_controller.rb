 class UserSessionsController < ApplicationController
  skip_before_action :require_user, :only => [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      checker = AchievementsChecker.new(current_user, 'logged_in')
      session[:new_badge] = checker.check

      redirect_to root_path
    else
      flash.now[:notice] = 'Chyba. Tato kombinace e-mailu a hesla není správná.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end
end
