---
layout: default
title:
nav_order: 1
description: >-
  HasuraHandler is a Rails framework that makes building microservices for Hasura easy.
  HasuraHandler also simplifies adding Hasura to an existing Rails stack.
permalink: /
last_modified_date: 2020-07-27T05:39:31+0000
---

# Build Realtime Rails apps
{: .fs-9 }

HasuraHandler is a Rails framework that makes building microservices for Hasura easy.
HasuraHandler also simplifies adding Hasura to an existing Rails stack.
{: .fs-6 .fw-300 }

[Learn about Hasura](https://hasura.io/docs/1.0/graphql/manual/index.html){: .btn .fs-5 .mb-4 .mb-md-0 }
[Get Started](#quick-start){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

![tests](https://github.com/KazW/HasuraHandler/workflows/tests/badge.svg)

### Summary

HasuraHandler is a Rails engine, by default it will add 2 routes where it is mounted;
one for actions, one for events. Actions allow you to perform, such as calling a
payment provider and return a result back to your user. Events allow you to receive
information and react accordingly to it, such as sending a recently updated record
to a search backend/provider for indexing.

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
