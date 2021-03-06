module Entities
  class Link < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt&.iso8601 }

    expose :short_url, documentation: { type: 'String', desc: 'Shortened url' }
    expose :slug, documentation: { type: 'String', desc: 'URL slug' }
    expose :url, documentation: { type: 'String', desc: 'Original URL being shortened' }
    expose :usage_count, documentation: { type: 'Integer', desc: 'The number of times the slug has been accessed' }

    with_options(format_with: :iso_timestamp) do
      expose :expires_at, documentation: { type: 'String', desc: 'Datetime it expires in iso timestamp format' }
      expose :created_at, documentation: { type: 'String', desc: 'Datetime created in iso timestamp format' }
    end

    private

    def short_url
      Rails.application.routes.url_helpers.slug_url(object.slug)
    end
  end
end
