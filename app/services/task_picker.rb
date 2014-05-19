class TaskPicker
  def initialize user, category_id, difficulty
    @user = user
    @difficulty = difficulty
    @category = category_id == 'any' ? 'any' : Category.find(category_id)
  end

  def pick

    # Případ, kdy nebyla specifikována ani kategorie ani obtížnost.
    if @category == 'any' && @difficulty == 'any'
      return Task.all
    end

    # Případ, kdy nebyla specifikována kategorie, ale obtížnost ano.
    if @category == 'any'
      return Task.where(:difficulty => @difficulty)
    end

    # Speciální případ, kdy nebyla specifikována obtížnost, ale kategorie ano.
    if @difficulty == 'any'
      return @category.tasks
    end

    # Do proměnné 'tasks' se uloží všechny otázky spadající do vybrané kategorie.
    tasks = @category.tasks.where(:difficulty => @difficulty)

    # Může se stát, že uživatel ještě nikdy na žádnou otázku neodpovídal.
    if @user.answers.empty?

      # V takovém případě může být vybrána zcela libovolná otázka.
      return tasks

    else
      # Vyhledají se otázky, na které uživatel ještě neodpovídal.
      unanswered = tasks.where('id not in (?)', @user.answers.map(&:task_id))

      # Může nastat situace, kdy uživatel již na všechny otázky odpověděl.
      if unanswered.empty?

        # V takovém případě mu systém předhodí otázky, které uživatel v minulosti zodpověděl špatně.
        badly_answered = tasks.where('id in (?)', (@user.answers.where(:state => 1)).map(&:task_id))

        # Může nastat situace, kdy uživatel na žádnou otázku špatně neodpověděl.
        if badly_answered.empty?

          # V takovém případě mu systém předhodí dříve nepřesně zodpovězené otázky.
          somewhat_answered = tasks.where('id in (?)', (@user.answers.where(:state => 2)).map(&:task_id))

          # Může nastat situace, kdy uživatel na žádnou otázku nepřesně neodpověděl, tedy zodpověděl všechny otázky správně.
          if somewhat_answered.empty?

            # V takovém případě systém nemůže nabídnout žádnou otázku.
            return []

          else
            return somewhat_answered
          end

        else
          return badly_answered
        end

      else
        return unanswered
      end
    end
  end
end
