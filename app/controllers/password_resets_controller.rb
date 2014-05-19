class PasswordResetsController < ApplicationController
  skip_before_action :require_user

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token
      Notifier.password_reset(user).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.update(user_params)

      # Zamezí použití téhož odkazu v budoucnu
      @user.update(:password_reset_token, nil)

      # Přihlášení uživatele
      session[:user_id] = @user.id

      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
