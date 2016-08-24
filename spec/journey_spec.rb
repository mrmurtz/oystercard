require 'journey'

describe Journey do
  let(:station1) {double :station1}
  let(:station2) {double :station2}


  describe "#start" do
    it "saves an entry station" do
      subject.start(station1)
      expect(subject.entry_station).to eq station1
    end
  end

  describe "#finish" do
    it "saves an exit station" do
      subject.finish(station2)
      expect(subject.exit_station).to eq station2
    end
  end

  describe "#complete?" do
    it "returns true if both entry_station and exit_station" do
      subject.start(station1)
      subject.finish(station2)
      expect(subject.complete?).to eq true
    end
  end

  describe "#fare" do
    context "a complete journey" do
      it "return a the min fare" do
        subject.start(station1)
        subject.finish(station2)
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end

    context "incomplete journey" do
      it "returns a penalty fare" do
        subject.start(station1)
        expect(subject.fare).to eq Journey::PENALTY_FARE
      end
    end
  end

end
