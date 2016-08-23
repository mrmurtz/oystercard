require 'journey'

describe Journey do
  let(:station) {double :station, zone: 1}
  subject(:journey) {described_class.new}

  describe "#complete?" do
    it "knows when a journey is incomplete" do
      expect(journey).not_to be_complete
    end

    it "knows when you are in a journey" do

      expect()

    end

    it "knows when a journey is complete" do

    end
  end
end
