module Api
  class V10::Links < Grape::API
    helpers ::Helpers::LinksHelper
    helpers ::Helpers::ApiPaginationHelper

    namespace :links do
      desc 'Create a new link' do
        entity Entities::Link
      end
      params do
        requires :link, type: Hash do
          requires :url, type: String, desc: 'The URL to shorten'
        end
      end
      post '/' do
        link = Link.new(link_params)
        link.generate_slug

        if link.save
          present link, with: Entities::Link
        else
          say_unprocessable_entity_for link
        end
      end

      desc 'View link details' do
        entity Entities::Link
      end
      params do
        requires :slug, type: String, desc: 'The link slug value'
      end
      route_param :slug do
        get '/' do
          link = Link.find_by(slug: params[:slug])

          if link
            present link, with: Entities::Link
          else
            say_not_found
          end
        end
      end

      desc 'View all links' do
        entity Entities::Link
      end
      params do
        use :pagination
      end
      get '/' do
        links = Link.paginate(pagination_values.to_h)

        present links, with: Entities::Link
      end
    end
  end
end
