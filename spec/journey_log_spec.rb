require 'journey_log'

describe JourneyLog do

  let(:station) { double :station }
  let(:station2) { double :station2}

  describe '#start' do

    it 'should create a new journey' do
      subject.start(station)
      expect(subject.journey.entry_station).to eq station
    end

    it 'should return a penalty fare if there is already a current journey' do
      subject.start(station)
      subject.start(station)
      expect(subject.journey.fare).to eq 6
    end
  end

  describe "#finish" do

    it "should set an exit station" do
      subject.start(station)
      subject.finish(station2)
      expect(subject.journey.exit_station).to eq station2
    end
  end

  describe '#journeys' do
    it "stores an entry and exit station to the journey history on the card" do
      subject.start(station)
      subject.finish(station2)
      expect(subject.journeys).to include ({:entry_station => station, :exit_station =>station2})
    end
  end
end
