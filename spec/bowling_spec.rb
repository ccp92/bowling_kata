# frozen_string_literal: true

require 'bowling'

describe Bowling do
  let(:bowling) { Bowling.new }
  describe 'Given the scores of 10 frames' do
    it 'can score a gutterball game' do
      20.times { bowling.roll(0) }
      expect(bowling.total_score).to eq(0)
    end

    it 'can score with a total of 2 for each frame' do
      20.times { bowling.roll(1) }
      expect(bowling.total_score).to eq(20)
    end

    context 'scoring spares' do
      it 'can score with a spare on the first frame' do
        roll_a_spare
        bowling.roll(1)
        17.times { bowling.roll(1) }
        expect(bowling.total_score).to eq(29)
      end

      it 'can score with a spare on frame 1 and 2' do
        2.times { roll_a_spare }
        bowling.roll(1)
        15.times { bowling.roll(0) }
        expect(bowling.total_score).to eq(31)
      end

      it 'can score with a spare on the final turn' do
        18.times { bowling.roll(0) }
        roll_a_spare
        bowling.roll(1)
        expect(bowling.total_score).to eq(11)
      end
    end

    context 'scoring strikes' do
      it 'can score with a strike on the first turn' do
        roll_a_strike
        2.times { bowling.roll(1) }
        16.times { bowling.roll(0) }
        expect(bowling.total_score).to eq(14)
      end

      it 'can score with a strike on the final turn' do
        18.times { bowling.roll(0) }
        roll_a_strike
        2.times { bowling.roll(1) }
        expect(bowling.total_score).to eq(12)
      end

      it 'can score with a strike on two consecutive turns' do
        2.times { bowling.roll(0) }
        2.times { roll_a_strike }
        2.times { bowling.roll(1) }
        12.times { bowling.roll(0) }
        expect(bowling.total_score).to eq(35)
      end

      it 'can score with a strike on final three rolls' do
        18.times { bowling.roll(0) }
        3.times { roll_a_strike }
        expect(bowling.total_score).to eq(30)
      end
    end
  end

  private

  def roll_a_strike
    bowling.roll(10)
  end

  def roll_a_spare
    bowling.roll(9)
    bowling.roll(1)
  end
end
