class TaskEvaluator
  def initialize user, task, answers
    @user = user
    @task = task
    @answers = answers

    @result = 0
    @gain = 0
  end

  def evaluate
    # Proměnná answers je nil jen v případě, že uživatel na otázku nijak neodpověděl.
    if @answers == nil

      # V takovém případě není co řešit a rovnou vrátíme výsledek 0 a bodový zisk 0.
      return [0, 0]

    # Zjistí se, zda-li uživatel neodpovídal na otázku, kdy se ohodntil sám.
    elsif @answers.first == 'self_evaluated'

      # V takovém případě se za výsledek považuje právě uživatelův pocit.
      @result = @answers.second.to_i

    else
      number_of_correct_choices = (@task.choices.select {|choice| choice.correct}).count
      number_of_correct_answers = 0

      @answers.each do |answer|
        number_of_correct_answers += 1 if @task.choices.find(answer).correct
      end

      if number_of_correct_answers == 0 || @answers.count == @task.choices.count
        @result = 1
      elsif number_of_correct_answers == number_of_correct_choices
        @result = 3
      else
        @result = 2
      end
    end

    # Vytvoří se záznam o odpovědi na tuto otázku
    answer = @user.answers.find_or_create_by(task_id: @task.id)
    answer.state = @result
    answer.save

    # Volá se metoda aktualizující skóre
    update_points

    # Do view se vrátí informace o výsledku a bodovém zisku
    return [@result, @gain]
  end

  def update_points
    # Podle výsledku definujeme bodový zisk
    @gain = (@result - 1) * @task.difficulty * 5

    # Pro každou kategorii, do které otázka spadá, jsou aktualizovány uživatelovy skills
    @task.categories.each do |category|
      skill = @user.skills.find_or_create_by(category_id: category.id)
      skill.increment(:points, @gain)
      skill.level = 1 # todo
      skill.save
    end

    # Zároveň se aktualizuje celkové bodové konto uživatele
    @user.increment(:points, @gain)

    @user.save
  end
end
