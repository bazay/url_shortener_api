class RedirectsController < ApplicationController
  include RenderPageNotFound

  rescue_from ActiveRecord::RecordNotFound do
    render_page_not_found
  end

  def show
    link.increment!(:usage_count)

    redirect_to link.url
  end

  private

  def link
    @link ||= Link.find_by!(slug: params[:slug])
  end
end
