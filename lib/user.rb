class User < ApplicationRecord
  attribute :uid, String
  validates :uid, presence: true

  class << self
    ## Methods provided in super class, ApplicationRecord
    # Equivalent to ActiveRecord's .all for scoping/chaining
    def all
      super
    end

    # ActiveRecord-esque .first_or_create!
    # Usage:  User.where(uid: '123').first_or_create!
    # Raises: Errors::RecordNotUnique occassionally
    def first_or_create!(*args)
      log_attempt!
      super(*args)
    end

    ## Methods provided by the candidate
    # TODO: robustly invoke .first_or_create!
    def first_or_create_with_retry!(attributes = nil, &block)
      all.first_or_create! attributes, &block
    end

    ## Spies
    def log_attempt!
      puts 'Attempting .first_or_create!' # rubocop:disable Output
    end
  end
end
