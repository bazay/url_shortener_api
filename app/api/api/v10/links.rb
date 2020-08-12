module Api
  class V10::Links < Grape::API
    helpers ::Helpers::LinksHelper

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
        link.generate_slug
        if link.save
          present link, with: Entities::Link
        else
          say_unprocessable_entity_for link
        end
      end
    end
  end
end
