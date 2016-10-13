require 'active_model'
require 'errors'
require 'virtus'

class ApplicationRecord
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
  include Virtus.model

  @@attempts = 0
  @@counter  = 0
  @@records  = []
  @@conflict = true

  attribute :id,        Integer
  attribute :persisted, Boolean, default: false
  validates :id, presence: true

  class << self
    def all
      self
    end

    def first_or_create!(attributes = {}, &block)
      # Invoke new record
      record = new(attributes, &block)

      # Raise on invalidation
      raise Errors::RecordInvalid unless record.valid?

      # Raise uniqueness error
      @@attempts += 1
      raise Errors::RecordNotUnique if @@attempts % 3 != 0 && @@conflict

      # Save and return
      record.tap(&:save!)
    end
  end

  before_validation do
    @@counter += 1
    self.id = @@counter
  end

  def save!
    self.persisted = true
    @@records << self
  end
end
