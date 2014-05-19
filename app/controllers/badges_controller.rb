class BadgesController < ApplicationController
  def build_badges
    badges_builder = BadgesBuilder.new
    badges_builder.build_all_badges

    flash[:notice] = 'Odznaky zavedeny do databáze.'
    redirect_to root_path
  end
end
