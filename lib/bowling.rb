# frozen_string_literal: true

#  go away rubocop
class Bowling
  def initialize
    @scores = []
  end

  def roll(knocked_pins)
    @scores.push(knocked_pins)
  end

  def total_score
    (0...20).step(2) do |i|
      insert_next_frame_score_after_strike(i) if strike?(i)
      add_next_roll_to_current(i) if spare?(i)
    end

    sum_scores
  end

  private

  def sum_scores
    @scores[0...20].sum
  end

  def spare?(first_roll_in_frame)
    calc_two_consecutive_rolls(first_roll_in_frame) == 10
  end

  def add_next_roll_to_current(first_roll_in_frame)
    @scores[first_roll_in_frame + 1] += @scores[first_roll_in_frame + 2]
  end

  def strike?(first_roll_in_frame)
    @scores[first_roll_in_frame] == 10
  end

  def insert_next_frame_score_after_strike(first_roll_in_frame)
    next_two_rolls = calc_two_consecutive_rolls(first_roll_in_frame + 1)
    @scores.insert(first_roll_in_frame + 1, next_two_rolls)
  end

  def calc_two_consecutive_rolls(first_roll)
    @scores[first_roll] + @scores[first_roll + 1]
  end
end
