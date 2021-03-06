require 'json_api_client'

if defined?(ActiveSupport) == 'constant'
  # Use correct page parameters for Network API
  # (only works when included in Rails environment)
  begin
    JsonApiClient::Paginating::Paginator.page_param = 'number'
    JsonApiClient::Paginating::Paginator.per_page_param = 'size'
  rescue NoMethodError
    # probably in test environment.
    nil
  end
end

require 'network-api/version'
require 'network-api/authentication'
require 'network-api/base'
require 'network-api/api_token'
require 'network-api/app_metric'
require 'network-api/application_organization'
require 'network-api/application'
require 'network-api/coupon'
require 'network-api/email'
require 'network-api/group'
require 'network-api/invitation'
require 'network-api/invoice_item'
require 'network-api/invoice'
require 'network-api/location'
require 'network-api/mailing_list'
require 'network-api/mailing_list_membership'
require 'network-api/organization'
require 'network-api/payment'
require 'network-api/payment_method'
require 'network-api/plan'
require 'network-api/role'
require 'network-api/subscription'
require 'network-api/usage_record'
require 'network-api/user'
require 'network-api/users_role'
