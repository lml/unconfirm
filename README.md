# MaybeConfirm

This gem helps in creating user-confirmable UI actions with a
persistent "Don't show this message again." facility.

## Objectives

The goals are to make adding confirmation dialog to an application as
simple as possible.  Once the gem is added, the only change that would
be required is to add the `maybe_confirm` class to the action HTML
elements that need to be intercepted along with a couple of data
attributes that specify the setting and the confirmation message.

## Installation

Add this line to your application's Gemfile:

    gem 'maybe_confirm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maybe_confirm

## Usage

1. DB Migration
2. Add class name and data attributes, perhaps using a helper
   function?
3. Test to make sure.

## Contributing

See <CONTRIBUTING.md>.
