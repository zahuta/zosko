class TasksController < ApplicationController
  before_action :set_task, except: [:next]

  def do
  end

  def evaluate
    @choices = params[:choices]

    # Pokud je přítomen parametr 'feeling', uživatel odpovídal textově a ohodnotil se sám
    if params[:feeling] != nil

      # Volá se proto služba TaskEvaluator s parametrem feeling, který reprezentuje sebeohodnocení
      evaluator = TaskEvaluator.new(current_user, @task, ['self_evaluated', params[:feeling]])
      evaluator.evaluate

      redirect_to next_task_path
    else

      # Pokud jde o otevřenou otázku, proběhne přesměrování na stránku, kde se uživatel sám ohodnotí
      if @type == 'text'
        redirect_to self_evaluate_task_path(params[:choices])

      # Pokud jde o uzavřenou otázku, systém odpovědi vyhodnotí sám
      else
        evaluator = TaskEvaluator.new(current_user, @task, @choices)
        results = evaluator.evaluate

        @result = results.first
        @gain = results.second
      end

    checker = AchievementsChecker.new(current_user, 'task_answered')
    session[:new_badge] = checker.check

    end
  end

  def self_evaluate
    @text = params[:choices]
  end

  def next
    if params[:next_category] && params[:next_difficulty]
      session[:next_category] = params[:next_category]
      session[:next_difficulty] = params[:next_difficulty]
    end

    if !(session[:next_category] && session[:next_difficulty])
      redirect_to root_path and return
    end

    picker = TaskPicker.new(current_user, session[:next_category], session[:next_difficulty])
    tasks = picker.pick

    # Metoda sample vybere náhodnou otázku z nalezených kandidátů
    task = tasks.sample

    if task
      redirect_to do_task_path(task)
    else
      flash[:notice] = 'Všechny otázky vyhovující tomuto výběru byly zodpovězeny.'
      redirect_to root_path
    end
  end

  private

  def set_task
    @task = Task.includes(:choices).find(params[:id])
    @type = @task.get_type
    @success_rate = @task.get_success_rate
  end
end
