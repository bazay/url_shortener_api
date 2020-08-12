module Helpers
  module LinksHelper
    private

    def link
      @link ||= Link.new(link_params)
    end

    def link_params
      params[:link]
    end
  end
end
