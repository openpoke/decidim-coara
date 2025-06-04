# frozen_string_literal: true

if ENV["UOC_CLIENT_ID"].present?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :openid_connect, {
      name: :uoc,
      scope: [:defaultData_OpenID],
      response_type: :code,
      uid_field: "preferred_username",
      discovery: true,
      issuer: ENV.fetch("UOC_ISSUER", nil),
      client_options: {
        port: 443,
        scheme: "https",
        host: ENV.fetch("UOC_HOST", nil),
        identifier: ENV.fetch("UOC_CLIENT_ID", nil),
        secret: ENV.fetch("UOC_CLIENT_SECRET", nil),
        redirect_uri: ENV.fetch("UOC_CALLBACK", "https://decidim-coara.techlab.uoc.edu/users/auth/uoc/callback")
      }
    }
  end
  # Force Decidim to look at this provider if not defined in secrets.yml
  Rails.application.secrets[:omniauth][:uoc] = {
    enabled: true,
    icon: "login-circle-line"
  }
end
