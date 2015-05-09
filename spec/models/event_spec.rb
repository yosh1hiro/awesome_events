require 'rails_helper'

describe Event do
  describe '#name' do
    context 'when name is nil or blank' do
      context 'name is nil' do
        let(:event) { Event.new(name: nil)  }

        it 'not valid' do
          event.valid?
          expect(event.errors[:name]).to be_present
        end
      end

      context 'name is blank' do
        let(:event) { Event.new(name: '')  }

        it 'not valid' do
          event.valid?
          expect(event.errors[:name]).to be_present
        end
      end

      context 'there is contents' do
        
        context 'name is "Rails勉強会"' do
          let(:event) { Event.new(name: 'Rails勉強会') }

          it 'should valid' do
            event.valid?
            expect(event.errors[:name]).to be_blank
          end
        end

        context 'when less than 50 characters' do
          let(:event) { Event.new(name: 'a' * 50) }

          it 'should valid' do
            event.valid?
            expect(event.errors[:name]).to be_blank
          end
        end

        context 'when over than 51 characters' do
          let(:event) { Event.new(name: 'a' * 51) }

          it 'should not be valid' do
            event.valid?
            expect(event.errors[:name]).to be_present
          end
        end
      end
    end
  end
  describe '#created_by?' do
    let(:event) { FactoryGirl.create(:event) }
    
    context 'when argument is nil' do
      let(:user) { nil }
      it 'return false' do
        expect(event.created_by?(user)).to be_falsey
      end
    end

    context 'when #owner_id is the same as argument id' do
      let(:user) { double('user', id: event.id) }
      it 'return true' do
        expect(event.created_by?(user)).to be_truthy
      end
    end
  end

  describe '#rails?' do
    context 'when #name is "Rails勉強会"' do
      it 'response is true' do
        event = FactoryGirl.create(:event, name: 'Rails勉強会')
        expect(event.rails?).to eq true
      end
    end

    context 'when #name is "Ruby勉強会"' do
      it 'response is false' do
        event = FactoryGirl.create(:event, name: 'Ruby勉強会')
        expect(event.rails?).to eq false
      end
    end
  end
end
