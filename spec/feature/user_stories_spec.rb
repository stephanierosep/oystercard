require 'oystercard'
require 'station'

describe "feature tests" do
  let(:station) { Station.new }
  let(:exit_station) {Station.new}
  it 'has deafault balance of zero' do
    expect(Oystercard.new.balance).to eq(0)
  end

  it 'customer can add money to card' do
    card = Oystercard.new
    card.top_up(10)
    expect(card.balance).to eq(10)
  end

  it 'has a maximum balance of 90' do
    card = Oystercard.new
    expect{card.top_up(91)}.to raise_error("Error: card limit is #{Oystercard::MAX_LIMIT}")
  end


  it 'can touch in' do
    card = Oystercard.new
    expect(card).to respond_to(:touch_in).with(1).argument
  end

  it 'can touch out' do
    card = Oystercard.new
    expect(card).to respond_to(:touch_out)
  end

  it "returns #in_journey? as true after #touch_in(station)" do
    card = Oystercard.new
    card.top_up(50)
    card.touch_in(station)
    expect(card.in_journey?).to eq(true)
  end

  it 'must have a minimum balance of 1' do
    card = Oystercard.new
    expect{card.touch_in(station)}.to raise_error("Error, insufficient balance")
  end

  it 'After touch_out, the balance should be reduced by 1' do
    card = Oystercard.new
    card.top_up(50)
    card.touch_in(station)
    expect{card.touch_out(exit_station)}.to change{card.balance}.by(-1)
  end

  it "does not respond to deduct (it's a private method)" do
    expect(Oystercard.new).not_to respond_to(:deduct)
  end

  it "will remember the entry station" do
    card = Oystercard.new
    card.top_up(50)
    card.touch_in(station)
    expect(card.entry_station).to eq(station)
  end

  context("after completing a journey from entry to exit") do
    let(:entry) { Station.new }
    let(:exit) { Station.new }
    let(:card) { Oystercard.new }
    before(:each) do
      card.top_up(50)
      card.touch_in(entry)
      card.touch_out(exit)
    end
    it "will record exit_station" do
      expect(card.exit_station).to eq(exit)
    end
    it "will record the journey in an array of hashes called journey_history" do
      expect(card.journey_history.pop).to eq(entry_station: entry, exit_station: exit)
    end
  end





end
