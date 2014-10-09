# mandrill-mailer-rails

[![Build Status](https://travis-ci.org/bsedat/mandrill-mailer-rails.svg)](https://travis-ci.org/bsedat/mandrill-mailer-rails)

Handler for Rails' ActionMailer to send emails through Mandrill.

## Installation

In your `Gemfile`:

    gem 'mandrill-mailer-rails'

## Configuration

### Mandatory

Store your API Key in an environment variable or other safe place. It needs access to at least the `send` method.

In your `config/application.rb`:

    config.action_mailer.delivery_method = :mandrill
    config.mandrill_action_mailer.api_key = ENV['MANDRILL_API_KEY']

### Optional

#### Track Opens

Whether Mandrill should automatically insert a tracking image. Default: `false`.

    config.mandrill_action_mailer.track_opens = true

#### Track Clicks

Whether Mandrill should override your URLs and track clicks. Default `false`.

    config.mandrill_action_mailer.track_clicks = true
