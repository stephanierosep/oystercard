require 'journey'

describe Journey do

  let(:station) { double :station }
  subject(:journey) { Journey.new(station) }

  it 'knows if a journey is not complete' do
    expect(journey.complete?).to eq false
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

end
