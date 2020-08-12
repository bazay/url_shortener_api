module RenderPageNotFound
  extend ActiveSupport::Concern

  def render_page_not_found
    render file: 'public/404.html', formats: [:html], layout: false, status: :not_found
  end
end
