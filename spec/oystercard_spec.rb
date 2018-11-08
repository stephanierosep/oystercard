require 'oystercard'
require 'journey'

describe Oystercard do

  subject(:oystercard) {Oystercard.new}
  let(:station) {double}
  let(:exit_station) {double}

  it 'has deafault balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it 'can add money to balance' do
    oystercard.top_up(9)
    expect(oystercard.balance).to eq(9)
  end

  it 'has a maximum limit of 90 pounds' do
    expect{oystercard.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error("Error: card limit is #{Oystercard::MAX_LIMIT}")
  end

  it 'cannot deduct an amount that would make balance negative' do
    pending("We have changed deduct to a private method. Waiting for different costs to update")
     oystercard.top_up(10)
     expect{oystercard.deduct(15)}.to raise_error("balance cannot be negative")
   end

  it 'can touch in' do
    expect(oystercard).to respond_to(:touch_in)
  end

  it 'can touch out' do
    expect(oystercard).to respond_to(:touch_out)
  end

  it "returns #in_journey? as true after #touch_in" do
    oystercard.top_up(50)
    oystercard.touch_in("Barbican")
    expect(oystercard.in_journey?).to eq(true)
  end

  it 'returns #in_journey? as false after #touch_out' do
    oystercard.top_up(50)
    oystercard.touch_in(station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journey_history.last.exit_station).to eq(exit_station)
  end

  it 'After touch_out, the balance should be reduced by 1' do
    oystercard.top_up(50)
    oystercard.touch_in(station)
    expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-1)
  end

  it "does not respond to deduct (it's a private method)" do
    expect(oystercard).not_to respond_to(:deduct)
  end

  it "will remember the entry station" do
    oystercard.top_up(50)
    oystercard.touch_in(station)
    expect(oystercard.journey_history.last.entry_station).to eq(station)
  end

  context("after completing a journey from entry to exit") do
    let(:entry) { double }
    let(:exit) { double }
    before(:each) do
      oystercard.top_up(50)
      oystercard.touch_in(entry)
      oystercard.touch_out(exit)
    end

    it "will record the journey in an array of journeys called journey_history" do
      expect(oystercard.journey_history.last.entry_station).to eq(entry)
      expect(oystercard.journey_history.last.exit_station).to eq(exit)
    end
  end

end
