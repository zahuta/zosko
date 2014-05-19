class Admin::TasksController < ApplicationController
  before_action :require_admin

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @categories = Category.all

    # Vygeneruje pole pro 4 možnosti
    4.times { @task.choices.build }
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

    # Přidá pole pro novou možnost
    @task.choices.build
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Uloženo. #{view_context.link_to 'Vytvořit další?', new_admin_task_path}".html_safe
      redirect_to do_task_path(@task)
    else
      flash.now[:notice] = 'Chyba. Vyplnili jste povinná pole?'

      # Zajistí, že i v případě chyby bude k dispozici volné pole pro přidání další možnosti
      @task.choices.build

      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'Uloženo.'
      redirect_to edit_admin_task_path(@task)
    else
      flash.now[:notice] = 'Chyba. Vyplnili jste povinná pole?'

      # Zajistí, že i v případě chyby bude k dispozici volné pole pro přidání další možnosti
      @task.choices.build

      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Smazáno.'
    redirect_to admin_tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :query, :excerpt, :difficulty, :category_ids => [], :choices_attributes => [:id, :text, :explanation, :correct, :_destroy])
  end
end
