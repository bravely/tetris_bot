describe Api::Shape do
  describe '#random_shape' do
    let(:shape) { Api::Shape.new }
    let(:square_shape) { [[true, true], [true, true]] }
    it { expect(shape.name).to eq 'square' }
    it { expect(shape.shape).to eq square_shape }
  end
end
