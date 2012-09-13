# Noodall Poll

Noodall Poll allows the creation of user polls.

* An administrator will be able to create user polls that they will then be able to position within pages.
* Users will be able to select and submit a poll option.
* Once a user has submitted their poll option they will be able to see the poll results.

## Install

Add to your `Gemfile`

    gem 'noodall-poll', :git => 'git@github.com:noodall/noodall-poll.git'

Run `bundle install`

    bundle install

## Configuration

In `config/initializers/noodall.rb`

Noodall Poll adds a `UserPoll` component which you can add to your slots.

    Noodall::Node.slot :small, UserPoll

You can now create a new poll within the Noodall Administration.

