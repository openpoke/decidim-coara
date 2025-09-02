# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { github: "decidim/decidim", branch: "release/0.29-stable" }.freeze
gem "decidim", DECIDIM_VERSION
gem "decidim-decidim_awesome", github: "decidim-ice/decidim-module-decidim_awesome", branch: "ettiquette-participatory-texts"
gem "decidim-templates", DECIDIM_VERSION
gem "decidim-term_customizer", github: "Openpoke/decidim-module-term_customizer", branch: "main"

gem "bootsnap", "~> 1.3"
gem "deface"
gem "health_check"
gem "omniauth_openid_connect"
gem "puma", ">= 6.3.1"
gem "rails_semantic_logger"
gem "sentry-rails"
gem "sentry-ruby"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "brakeman", "~> 5.4"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 4.2"
end

group :production do
  gem "sidekiq"
  gem "sidekiq-cron"
end
