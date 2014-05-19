class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_save :downcase_email

  has_secure_password

  has_many :answers, dependent: :destroy
  has_many :tasks, through: :answers

  has_many :skills, dependent: :destroy
  has_many :categories, through: :skills

  has_many :achievements, dependent: :destroy
  has_many :badges, through: :achievements

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(32))
  end

  def get_current_streak
    right_answers = answers.where(:state => 3).order(updated_at: :desc)
    time = Time.now

    right_answers.each do |right_answer|
      if (time - right_answer.updated_at) < 48.hours
        time = right_answer.updated_at
      else
        break
      end
    end

    return ((Time.now - time) / 3600 / 24).to_i + 1
  end
end
