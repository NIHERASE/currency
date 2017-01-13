require 'rails_helper'

RSpec.describe Override, type: :model do
  describe 'validations' do
    context 'value' do
      let(:other_attrs) { { active_until: DateTime.now + 5.minutes } }

      it 'allows positive value' do
        ov = described_class.new({value: '1'}.merge(other_attrs))
        expect(ov).to be_valid
      end

      it 'allows decimail value with 0.01 precision' do
        ov = described_class.new({value: '1.01'}.merge(other_attrs))
        expect(ov).to be_valid
      end

      it 'doesn`t allow missing value' do
        ov = described_class.new(other_attrs)
        expect(ov).not_to be_valid
      end

      it 'doesn`t allow negative values' do
        ov = described_class.new({value: '-1'}.merge(other_attrs))
        expect(ov).not_to be_valid
      end

      it 'doesn`t allow decimail value with 0.1 precision' do
        ov = described_class.new({value: '1.1'}.merge(other_attrs))
        expect(ov).not_to be_valid
      end
    end

    context 'active_until' do
      let(:other_attrs) { { value: '1' } }

      it 'doesn`t allow missing active_until' do
        ov = described_class.new(other_attrs)
        expect(ov).not_to be_valid
      end
    end
  end

  describe '#active_until = arg' do
    subject { described_class.new }

    context 'when arg is DateTime' do
      let(:date_time) { DateTime.now }

      it 'assigns DateTime' do
        subject.active_until = date_time
        expect(subject.active_until).to equal(date_time)
      end
    end

    context 'when arg is time string' do
      let(:correct_time) { '2017-01-13T07:04+03:00' }
      let(:wrong_time)   { '__' }

      it 'converts correct_time to DateTime and assigns' do
        subject.active_until = correct_time
        expect(subject.active_until).to eq(DateTime.parse(correct_time))
      end

      it 'if converions fails assigns nil' do
        subject.active_until = wrong_time
        expect(subject.active_until).to be_nil
      end
    end
  end
end
