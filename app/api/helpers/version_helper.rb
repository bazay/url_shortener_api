module Helpers
  module VersionHelper
    API_VERSIONS = %w[v1.0].freeze

    private

    def app_version
      File.read(Rails.root.join('VERSION')).chomp
    end

    def latest_api_version
      API_VERSIONS.last
    end
  end
end
