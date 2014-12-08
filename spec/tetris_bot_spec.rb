require 'spec_helper'

describe TetrisBot do
  it 'has a version number' do
    expect(TetrisBot::VERSION).not_to be nil
  end

  describe '#choice' do
    context 'when playing with an empty field' do
      let(:bot) { Api.new }
      let!(:expected_gamestate) do
        gamestate = []
        18.times do
          row = []
          10.times { row << false }
          gamestate << row
        end
        2.times { gamestate << [true, true, false, false, false, false, false, false, false, false] }
        gamestate
      end
      before do
        bot.extend TetrisBot
        bot.choice
      end
      it { expect(bot.gamestate).to eq expected_gamestate }
    end

    context 'when playing with a field that already has pieces on it' do
      gamestate = []
      18.times do
        row = []
        10.times { row << false }
        gamestate << row
      end
      2.times { gamestate << [true, true, false, false, false, false, false, false, false, false] }
      let(:bot) { Api.new(gamestate: gamestate) }
      let(:expected_gamestate) do
        gamestate = []
        18.times do
          row = []
          10.times { row << false }
          gamestate << row
        end
        2.times { gamestate << [true, true, true, true, false, false, false, false, false, false] }
        gamestate
      end
      before do
        bot.extend TetrisBot
        bot.choice
      end
      it { expect(bot.gamestate).to eq expected_gamestate }
    end
  end
end
