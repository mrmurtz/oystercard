require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

    let(:entry_station) {double :entry_station}
    let(:exit_station) {double :exit_station}
    let(:journey) {{:entry_station => entry_station, :exit_station => exit_station}}


  describe 'initialize' do
    it 'card has a balance of zero' do
      expect(oystercard.balance).to eq 0
    end

    it "is able to store journey history" do
      expect(oystercard.journeys).to eq []
    end


  end

  describe '#in_journey?' do
    it 'not in journey initially' do
      expect(oystercard.in_journey?).to be false
    end
  end

  describe '#top_up' do

    context 'when under limit' do
    it 'responds to top-up with one argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'can increase the balance' do
      expect{oystercard.top_up 10}.to change{oystercard.balance}.by 10
    end
  end

    context 'when over limit' do
    it 'raises an error when more than £90 is added' do
      LIMIT = Oystercard::LIMIT
      oystercard.top_up(LIMIT)
      expect{ oystercard.top_up 5 }.to raise_error "Limit £#{LIMIT} exceeded"
    end
  end
  end

  context 'when travelling' do

    describe '#touch_in' do
      it 'can touch in' do
        oystercard.top_up(10) #need stub
        oystercard.touch_in(entry_station)
        expect(oystercard).to be_in_journey
      end

      it 'responds to 1 argument' do
        oystercard.top_up(10)
        expect(oystercard).to respond_to(:touch_in).with(1).argument
      end

      it 'remembers the entry_station' do
        oystercard.top_up(10)
        oystercard.touch_in(entry_station)
        expect(oystercard.entry_station).to eq entry_station
      end

      context 'When balance is less than £1' do
        it 'raises an error' do
          expect { oystercard.touch_in(entry_station) }.to raise_error 'not enough credit'
        end
      end
    end

   describe '#touch_out' do
     it 'can touch out' do
       oystercard.top_up(10) #need stub
       oystercard.touch_in(entry_station)
       oystercard.touch_out(exit_station)
       expect(oystercard).not_to be_in_journey
     end

     it "reduces balance by MINIMUM_FARE when touch_out is called" do
       oystercard.top_up(10)
       oystercard.touch_in(entry_station)
       expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
     end

     it "remembers an exit station" do
       oystercard.top_up(10)
       oystercard.touch_in(entry_station)
       oystercard.touch_out(exit_station)
       expect(oystercard.exit_station).to eq exit_station
     end


     it "stores an entry and exit station to the journey history on the card" do
       oystercard.top_up(10)
       oystercard.touch_in(entry_station)
       oystercard.touch_out(exit_station)
       expect(oystercard.journeys).to include journey
     end
   end
 end
end
