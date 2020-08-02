---
layout: default
title: Home
nav_exclude: true
permalink: /
last_modified_date: 2020-07-27T05:39:31+0000
---

# Build Realtime GraphQL Rails Apps
{: .fs-9 }

HasuraHandler is a Rails framework that makes building microservices for Hasura easy.
HasuraHandler also simplifies adding Hasura to an existing Rails app.
{: .fs-6 .fw-300 }

[Learn about Hasura](https://hasura.io/docs/1.0/graphql/manual/index.html){: .btn .fs-5 .mb-4 .mb-md-0 }
[Get Started](#quick-start){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

[![tests](https://github.com/KazW/HasuraHandler/workflows/tests/badge.svg)](https://github.com/KazW/HasuraHandler/actions?query=workflow%3Atests) [![Maintainability](https://api.codeclimate.com/v1/badges/38864d7565ab11729b6b/maintainability)](https://codeclimate.com/github/KazW/HasuraHandler/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/38864d7565ab11729b6b/test_coverage)](https://codeclimate.com/github/KazW/HasuraHandler/test_coverage)

## Summary

HasuraHandler is a Rails engine, by default it will add 2 routes where it is
mounted; one for actions, one for events. Actions allow you to return information
to a GraphQL query/mutation, such as verifying a usename/password and generating a
login token. Events allow you to receive information and react to it accordingly,
such as sending an updated record to a search backend/provider for indexing.

## What can Hasura do?

When using Hasura as part of a Rails app, Hasura can act as several pieces of
infrastructure:
* A GraphQL API gateway that supports subscriptions over websockets.
* An internal event-based webhook service that delivers records to endpoints
  when they're insertted/updated/deleted.
* As a data access layer where services use it as a master data store.
* An internal webhook scheduling service that can deliver one-off or recurring
  events to endpoints.

Since Hasura can be used in so many ways, it can be added to an application
stack incrementally for existing Rails apps. For new Rails apps, considering
ways to use this functionality can radically alter the way you think about
building and architecting your app.

## Quick Start

1. Add the gem to your project
```ruby
gem 'hasura_handler'
```

2. Create `config/initializers/hasura_handler.rb`:
```ruby
HasuraHandler.setup do |config|
  config.auth_key = ENV['HASURA_SERVICE_KEY'] || Rails.application.credentials.hasura_service_key
end
```

3. Create the following directories:
* `app/actions`
* `app/reactions`

4. Add routes in `config/routes.rb`:
```ruby
mount HasuraHandler::Engine => '/hasura'
```

5. Add the following to both `config/environments/{development,test}.rb`:
```ruby
config.to_prepare do
  Dir[Rails.root.join('app', '{actions,reactions}', '*.rb')].each{ |file| require_dependency file }
end
```

6. Create event trigger in Hasura: **TODO**

7. Create event reaction in `app/reactions/welcome_user.rb`:
```ruby
    class WelcomeUser < HasuraHandler::EventHandler
      match_by trigger: 'user_inserted'

      def run
        Rails.logger.info('A new user signed up!')
      end
    end
```
