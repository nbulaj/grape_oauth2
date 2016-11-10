module GrapeOAuth2
  class Configuration
    DEFAULT_CLIENT_CLASS = '::Application'.freeze
    DEFAULT_ACCESS_TOKEN_CLASS = '::AccessToken'.freeze
    DEFAULT_ACCESS_GRANT_CLASS = '::AccessGrant'.freeze
    DEFAULT_RESOURCE_OWNER_CLASS = '::User'.freeze

    DEFAULT_TOKEN_LIFETIME = 7200 # in seconds
    DEFAULT_CODE_LIFETIME = 7200

    DEFAULT_REALM = 'OAuth 2.0'.freeze

    SUPPORTED_GRANT_TYPES = %w(password client_credentials refresh_token).freeze

    attr_accessor :client_class, :access_token_class, :resource_owner_class,
                  :access_grant_class

    attr_accessor :allowed_grant_types, :code_lifetime, :token_lifetime,
                  :issue_refresh_token, :revoke_after_refresh, :realm

    def initialize
      initialize_classes

      self.token_lifetime = DEFAULT_TOKEN_LIFETIME
      self.code_lifetime = DEFAULT_CODE_LIFETIME
      self.allowed_grant_types = %w(password client_credentials)

      self.issue_refresh_token = false
      self.revoke_after_refresh = false

      self.realm = DEFAULT_REALM
    end

    def default_token_authenticator
      lambda do |request|
        access_token_class.authenticate(request.access_token) || request.invalid_token!
      end
    end

    private

    def initialize_classes
      self.client_class = DEFAULT_CLIENT_CLASS
      self.access_token_class = DEFAULT_ACCESS_TOKEN_CLASS
      self.resource_owner_class = DEFAULT_RESOURCE_OWNER_CLASS
      self.access_grant_class = DEFAULT_ACCESS_GRANT_CLASS
    end
  end
end
