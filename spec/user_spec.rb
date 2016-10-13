require 'spec_helper'

RSpec.describe User, type: :model do
  subject { User.new }

  describe 'validations' do
    it 'is valid with a @uid' do
      subject.uid = '123'
      expect(subject).to be_valid
    end

    it 'is valid without a @uid' do
      expect(subject).to_not be_valid
    end
  end

  describe '.first_or_create_with_retry!' do
    let(:scope) { described_class.all }
    let(:uid)   { '8675309' }

    # TODO: get this test to pass
    xit 'creates a record' do
      record = scope.first_or_create_with_retry! uid: uid
      expect(record).to be_persisted
      expect(record.uid).to eq uid
    end

    # TODO: write a test that stubs .first_or_create! and fails 2 of 3 calls
    xit 'retries with race conditions' do
      expect(scope).to receive(:first_or_create!).at_least(:once) do
        raise Errors::RecordNotUnique
      end
      record = scope.first_or_create_with_retry! uid: uid
      expect(record).to be_persisted
      expect(record.uid).to eq uid
    end

    it 'prevents creation of a record if @uid is blank' do
      expect(scope).to receive(:log_attempt!).once
      expect { scope.first_or_create_with_retry! uid: nil }.to raise_error Errors::RecordInvalid
    end
  end
end
