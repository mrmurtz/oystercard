require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

    let(:entry_station) {double :entry_station}
    let(:exit_station) {double :exit_station}
    let(:journey) {double :journey}


  describe 'initialize' do
    it 'card has a balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end


  describe '#top_up' do
    context 'when under limit' do

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
      context 'When balance is less than £1' do
        it 'raises an error' do
          expect { oystercard.touch_in(entry_station) }.to raise_error 'not enough credit'
        end
      end

      context "touching in when not touched out" do
        it "charges a pen fare" do
          subject.top_up(10)
          subject.touch_in(entry_station)
          expect{subject.touch_in(entry_station)}.to change{subject.balance}.by(-6)
        end
      end
    end

   describe '#touch_out' do

     it "charges the min fare" do
       subject.top_up(10)
       subject.touch_in(entry_station)
       expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-1)
     end

     it "charges a penalty fare when touching out if there is no entry station" do
       subject.top_up(10)
       expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-6)
     end
   end
 end
end
