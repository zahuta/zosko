class UsersController < ApplicationController
  skip_before_action :require_user, :only => [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  def make_admin
    @user = current_user
    @user.admin = !@user.admin
    @user.save
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save

      # Uživatel je po registraci automaticky přihlášen
      session[:user_id] = @user.id

      # Uživatel je odměněn odznakem za registraci
      checker = AchievementsChecker.new(current_user, 'registered')
      session[:new_badge] = checker.check

      flash[:notice] = 'Registrace proběhla úspěšně. Byli jste automaticky přihlášeni.'
      redirect_to root_path
    else
      flash.now[:notice] = 'Chyba. Možná jste již zaregistrovaní nebo jste nevyplnili všechna pole.'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Uloženo.'
      redirect_to root_path
    else
      flash.now[:notice] = 'Chyba. Vyplnili jste všechna pole? Shodují se hesla?'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
