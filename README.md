# IDEO Network API - Ruby

Ruby wrappers for IDEO Network API models.

Master Branch: [ ![Codeship Status for ideo/network-api-ruby](https://app.codeship.com/projects/80e7f660-950f-0136-6e5f-4e3f8275d3aa/status?branch=master)](https://app.codeship.com/projects/304778)

## Installing

Add to your `Gemfile`:

```ruby
gem 'network-api-ruby', git: 'https://github.com/ideo/network-api-ruby.git'
```

Then `bundle install`.

## Usage

These three configuration variables must be set in an initializer (e.g. `/config/initializers/network_api.rb`):

```
require 'network-api'

NetworkApi::Base.configure(
  url: 'https://profile.ideo.com/api/v1',
  api_token: ENV['IDEO_NETWORK_API_TOKEN'],
  client_id: ENV['IDEO_NETWORK_OAUTH_CLIENT_ID']
)
```

Then you can use any of the supported models:

```
NetworkApi::ApiToken
NetworkApi::ApplicationOrganization
NetworkApi::Application
NetworkApi::AppMetric
NetworkApi::Coupon
NetworkApi::Email
NetworkApi::InvoiceItem
NetworkApi::Invoice
NetworkApi::Location
NetworkApi::Organization
NetworkApi::PaymentMethod
NetworkApi::Plan
NetworkApi::Role
NetworkApi::Subscription
NetworkApi::UsageRecord
NetworkApi::User
NetworkApi::UsersRole
```

There is also an authentication utility class that is useful for generating auth URLs:

```
# URL with oAuth params for logging in
# (cookies comes from a Rails controller context)
NetworkApi::Authentication.sign_in_url(redirect_url: '...', cookies: cookies)

# URL with oAuth params for creating a new account
NetworkApi::Authentication.sign_up_url(redirect_url: '...', cookies: cookies)

# URL with oAuth params to automatically authenticate user with a specific provider
NetworkApi::Authentication.provider_auth_url(
  provider: 'ford',
  redirect_url: '...',
  cookies: cookies
)
```

To enable detailed request logging, you can set `ENV['DEBUG'] = '1'`
