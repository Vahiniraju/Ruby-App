class Question < ApplicationRecord
  VALID_QUESTION = /\A\S/
  belongs_to :user
  has_many :answers
  accepts_nested_attributes_for :answers
  validates :title, presence: true
  validate :check_answers
  acts_as_taggable


  def check_answers
    errors.add(:base, "question should have 3 answers") if answers.length != 3
    errors.add(:base, "Please select correct answer") if answers.select{|a| a.is_correct}.length != 1
  end

  def correct_answer
    self.answers.where(is_correct: true).first
  end

end
