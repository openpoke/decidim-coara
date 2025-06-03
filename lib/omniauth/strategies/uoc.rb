# frozen_string_literal: true

require "omniauth-oauth2"
require "open-uri"

module OmniAuth
  module Strategies
    class Uoc < OmniAuth::Strategies::OAuth2
      args [:client_id, :client_secret, :site]

      option :name, :uoc
      option :site, nil
      option :client_options, {}

      uid do
        raw_info["sub"]
      end

      info do
        {
          email: raw_info["email"],
          nickname: raw_info["username"],
          name: raw_info["displayName"],
          locale: raw_info["preferredLanguage"],
          avatar_url: "http://cv.uoc.edu/UOC/mc-icons/fotos/#{raw_info["username"]}.jpg"
        }
      end

      extra do
        {
          employee_number: raw_info["employeeNumber"],
          locale: raw_info["preferredLanguage"],
          rat: raw_info["rat"],
          affiliations: raw_info["eduPersonAffiliation"]
        }
      end

      def client
        options.client_options[:site] = options.site
        options.client_options[:authorize_url] = URI.join(options.site, "protocol/openid-connect/auth").to_s
        options.client_options[:revoke_url] = URI.join(options.site, "protocol/openid-connect/revoke").to_s
        options.client_options[:token_url] = URI.join(options.site, "protocol/openid-connect/token").to_s
        super
      end

      def raw_info
        Rails.logger.info "Fetching raw info from UOC"
        Rails.logger.info "Access token: #{access_token.inspect}"
        Rails.logger.info "User info: #{access_token.get("protocol/openid-connect/userinfo").inspect}"
        @raw_info ||= access_token.get("protocol/openid-connect/userinfo").parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
