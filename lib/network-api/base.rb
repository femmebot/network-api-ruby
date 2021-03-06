# Base resource for models on Network API

require 'securerandom'

module NetworkApi
  class Base < JsonApiClient::Resource
    class_attribute :api_token, :client_id

    STATE_COOKIE_NAME = 'IdeoSSO-State'.freeze

    # There is a bug with included resources where ID is cast as an integer,
    # and then the resource can't be auto-linked
    property :id, type: :string
    property :number, type: :float

    def self.configure(url:, api_token:, client_id:)
      self.site = url # e.g. https://profile.ideo.com/api/v1/
      self.api_token = api_token
      self.client_id = client_id

      # Sets up connection with token
      connection do |connection|
        # Set Api Token header
        connection.use FaradayMiddleware::OAuth2,
                       Base.api_token,
                       token_type: 'bearer'

        # Log requests if DEBUG == '1'
        if defined?(Rails) == 'constant' && ENV['DEBUG'] == '1'
          connection.use Faraday::Response::Logger
        end
      end
    end

    def self.state(cookies)
      existing_state = cookies[STATE_COOKIE_NAME]
      return existing_state if existing_state.present?
      cookies[STATE_COOKIE_NAME] = SecureRandom.uuid
    end

    # Version 1.5.3 doesn't properly parse out relationships
    # (the keys are ints, so it doesn't match them)
    def included_relationship_json(name)
      return if relationships[name].blank? ||
                relationships[name]['data'].blank?
      type = relationships[name]['data']['type']
      id = relationships[name]['data']['id']
      included_data = last_result_set.included.data[type]
      return if included_data.blank?
      included_data[id.to_i] || included_data[id.to_s]
    end
  end
end
