require 'spec_helper'

RSpec.describe ApplicationRecord, type: :model do
  subject { ApplicationRecord.new }

  describe '.first_or_create!' do
    before :each do
      described_class.class_variable_set :@@attempts, 0
      described_class.class_variable_set :@@conflict, true
    end

    it 'fails every 2 of 3 attempts' do
      expect { described_class.first_or_create! }.to raise_error(Errors::RecordNotUnique)
      expect { described_class.first_or_create! }.to raise_error(Errors::RecordNotUnique)
      record = described_class.first_or_create!
      expect(record).to be_a ApplicationRecord
      expect(record).to be_persisted
    end
  end
end
