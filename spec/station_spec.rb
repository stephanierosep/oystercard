require 'station'

describe Station do
  let(:station) { Station.new(1) }
  it "#zone give the zone of the station. It should be possible to set the zone during initialization" do
    expect(station.zone).to eq 1
  end
end
