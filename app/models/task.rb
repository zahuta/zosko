class Task < ActiveRecord::Base
  validates :query, presence: true
  validates :difficulty, presence: true

  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true

  has_and_belongs_to_many :categories

  has_many :answers, dependent: :destroy
  has_many :users, through: :answers

  def get_type
    return 'none' if choices.count == 0

    number_of_correct_answers = 0

    choices.each do |choice|
      number_of_correct_answers += 1 if choice.correct
    end

  	if number_of_correct_answers == choices.count
      'text'
  	elsif number_of_correct_answers > 1
  		'checkbox'
  	elsif number_of_correct_answers == 1
  		'radio'
    end
	end

  def get_success_rate
    total = Answer.where(:task_id => id)
    right = total.where(:state => 3)

    if total.count == 0
      0
    else
      (right.count.to_f / total.count) * 100
    end
  end
end
