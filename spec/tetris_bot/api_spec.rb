describe TetrisBot::Api do
  describe '#default_gamestate' do
    let(:api) { TetrisBot::Api.new }
    let(:default_gamestate) do
      gamestate = []
      20.times { gamestate << ("0" * 10) }
      gamestate
    end

    it 'should default to a 20x10 grid' do
      expect(api.gamestate).to eq default_gamestate
    end
  end
end