# Unconfirm

This gem helps in creating user-confirmable UI actions with a
persistent "Don't show this message again." facility.

## Installation

Add this line to your application's Gemfile:

    gem 'unconfirm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unconfirm

## Usage

1. DB Migration:

        $ rake unconfirm_engine:install:migrations
        $ rake db:migrate

2. Update layout: Edit your `application.html.erb` or equivalent layout
   file and add the following:


   Just before `body` tag is closed:

        <%= include_unconfirm %>
        <%= unconfirm_tag %>

3. Include unconfirm javascript assets. Add the following to your application
   assets (`application.js`):

        //= require unconfirm

4. Add configuration file(s) for unconfirm settings:

    Under `<RAILS ROOT>/config/unconfirm` add `<category>_setting.yml` file
    with any needed settings. See [example user settings file][example] for
    format and documentation.
    [example]: config/unconfirm/example_user_settings.yml


5. Enable unconfirm.


    Change something like the following:

        <%= f.submit "Submit", 
                :name => "save",
                :class => 'link_button',
                :confirm => "Are you sure?" %>

    to:

        <%= f.submit "Submit",
                :name => "save",
                :class => 'link_button unconfirm',
                :data => data_with_unconfirm('skip_save_message') %>

6. Test to make sure everything works as expected.

## Contributing

See [contribution guidelines](CONTRIBUTING.md).

