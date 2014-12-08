describe Api do
  describe '#default_gamestate' do
    let(:api) { Api.new }
    let(:default_gamestate) do
      gamestate = []
      20.times do
        row = []
        10.times { row << false }
        gamestate << row
      end
      gamestate
    end

    it 'should default to a 20x10 grid' do
      expect(api.gamestate).to eq default_gamestate
    end

    it 'should default cursor_x to position 5 of 10' do
      expect(api.cursor_x).to eq 4
    end
  end

  describe '#cursor_right' do
    context 'when gamestate is default' do
      let(:api) { Api.new }
      before do
        api.cursor_right
      end
      it { expect(api.cursor_x).to eq 5 }
    end

    context 'when cursor is all the way to the right and shape is a square' do
      let(:api) { Api.new(width: 10, cursor_x: 7, shape_name: 'square') }
      let(:modified_width) { ((api.width - api.current_shape.width) - 1) }
      it { expect(api.cursor_x).to eq 7 }
      it 'should not move further than the width' do
        api.cursor_right
        expect(api.cursor_x).to eq modified_width
      end
    end
  end

  describe '#cursor_left' do
    context 'when gamestate is default' do
      let(:api) { Api.new }
      before do
        api.cursor_left
      end
      it { expect(api.cursor_x).to eq 3 }
    end

    context 'when cursor is all the way to the right' do
      let(:api) { Api.new(width: 10, cursor_x: 0) }
      it { expect(api.cursor_x).to eq 0 }
      it 'should not move further than the width' do
        api.cursor_left
        expect(api.cursor_x).to eq 0
      end
    end
  end

  describe '#down' do
    context 'when gamestate is default' do
      let!(:expected_gamestate) do
        gamestate = []
        18.times do
          row = []
          10.times { row << false }
          gamestate << row
        end
        2.times { gamestate << [false, false, false, false, true, true, false, false, false, false] }
        gamestate
      end

      let(:api) { Api.new }
      
      before do
        api.down
      end

      it { expect(api.gamestate).to eq expected_gamestate }
    end

    context 'when a square piece is down' do
      square_down_gamestate = []
      18.times do
        row = []
        10.times { row << false }
        square_down_gamestate << row
      end
      2.times { square_down_gamestate << [false, false, false, false, true, true, false, false, false, false] }
      let(:api) { Api.new(gamestate: square_down_gamestate) }
      let(:expected_gamestate) do
        gamestate = []
        16.times do
          row = []
          10.times { row << false }
          gamestate << row
        end
        4.times { gamestate << [false, false, false, false, true, true, false, false, false, false] }
        gamestate
      end

      before do
        api.down
      end

      it { expect(api.gamestate).to eq expected_gamestate }
    end
  end
end