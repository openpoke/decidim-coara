# frozen_string_literal: true

require "omniauth/uoc"

if ENV["UOC_CLIENT_ID"].present?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider(
      :uoc,
      setup: lambda { |env|
               request = Rack::Request.new(env)
               organization = Decidim::Organization.find_by(host: request.host)
               provider_config = organization.enabled_omniauth_providers[:uoc]
               env["omniauth.strategy"].options[:client_id] = ENV["UOC_CLIENT_ID"]
               env["omniauth.strategy"].options[:client_secret] = ENV.fetch("UOC_CLIENT_SECRET", nil)
               env["omniauth.strategy"].options[:site] = ENV.fetch("UOC_SITE", nil)
             },
      scope: "decidim.rw"
    )
  end
  # Force Decidim to look at this provider if not defined in secrets.yml
  Rails.application.secrets[:omniauth][:uoc] = {
    enabled: true,
    icon: "login-circle-line",
    host: ENV.fetch("UOC_SITE", nil)
  }
end
