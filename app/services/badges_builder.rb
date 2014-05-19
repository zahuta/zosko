# Pomocná služba, která do databáze vloží všechny odznaky. Vhodné spustit při smazání db či prvním startu serveru.
class BadgesBuilder
  def initialize
  end

  def build_all_badges

    # odznak za dokončení registrace
    build_badge('registration_completed',
                'S chutí do toho a půl je hotovo',
                'Odhodlat se a začít je nejtěžší a vy jste to zvládli! Gratulujeme k úspěšné registraci.')

    # odznak za zodpovězení první otázky
    build_badge('first_task_answered',
                'První krok',
                'První otázka zodpovězena. Jen tak dál!')

    # odznak za získání 1 000 bodů
    build_badge('thousand_points',
                'Tisícovka',
                'Získat tisíc bodů není jen tak, ale pro vás to očividně nebyl žádný problém.')

    # odznak za získání 10 000 bodů
    build_badge('ten_thousand_points',
                'Desítka',
                'Nasbírat deset tisíc bodů, to chce vytrvalost a píli. Vládnete obojím!')

    # odznak za získání 10 000 bodů
    build_badge('five_day_streak',
                'Pracovní týden',
                'Už pět dní za sebou odpovídáte správně!')

    # odznak za získání 10 000 bodů
    build_badge('ten_day_streak',
                '10 dnů',
                'Hlavně to nepřetrhnout! Už 10 dnů v řadě správně odpovídáte.')

  end

  def build_badge name, title, description
    Badge.find_or_create_by(name: name) do |b|
      b.title = title
      b.description = description
      b.save
    end
  end
end
