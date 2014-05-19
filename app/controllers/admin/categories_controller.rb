class Admin::CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Uloženo.'
      redirect_to admin_categories_path
    else
      flash.now[:notice] = 'Chyba. Vyplnili jste název kategorie?'
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Uloženo.'
      redirect_to admin_categories_path
    else
      flash.now[:notice] = 'Chyba. Vyplnili jste název kategorie?'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'Smazáno.'
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :visible)
  end
end
