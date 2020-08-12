module Helpers
  module ApiPaginationHelper
    extend Grape::API::Helpers

    params :pagination do
      optional :page, type: Integer
      optional :per_page, type: Integer
    end

    private

    def pagination_values
      PaginationValues.new page: params[:page], per_page: params[:per_page]
    end
  end
end
