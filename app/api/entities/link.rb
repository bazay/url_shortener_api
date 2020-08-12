module Entities
  class Link < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt&.iso8601 }

    expose :slug, documentation: { type: 'String', desc: 'URL slug' }
    expose :url, documentation: { type: 'String', desc: 'Original URL being shortened' }
    expose :usage_count, documentation: { type: 'Integer', desc: 'The number of times the slug has been accessed' }

    with_options(format_with: :iso_timestamp) do
      expose :expires_at, documentation: { type: 'Datetime', desc: 'Datetime it expires in iso timestamp format' }
      expose :created_at, documentation: { type: 'Datetime', desc: 'Datetime created in iso timestamp format' }
    end
  end
end
