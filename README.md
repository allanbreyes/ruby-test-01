# Ruby Test 01

1. Given a simple `User` model with a field `@uid` that has application-level uniqueness validation. Why do we need a database-level uniqueness constraint?
1. Given a controller that invokes `.first_or_create!`, we often run into conflicts during concurrent requests. Complete the `.first_or_create_with_retry!` method to robustly handle conflicts.
1. Create an RSpec test that can mock the behavior to test that the method correctly handles concurrent conflicts.

### How to Run

1. Run `bundle install`.
1. Run `guard` for continuous testing, or run `rake` to test once.
