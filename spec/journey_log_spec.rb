require 'journey_log'

describe JourneyLog do

  let(:station) { double :station }

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


end
