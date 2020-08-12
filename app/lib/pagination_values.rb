class PaginationValues
  using Refinements::PositiveNumber

  DEFAULT_PER_PAGE = 30
  MAX_PER_PAGE = 50

  def initialize(page: nil, per_page: nil, default_per_page: DEFAULT_PER_PAGE, max_per_page: MAX_PER_PAGE)
    @page = page
    @per_page = per_page
    @default_per_page = default_per_page
    @max_per_page = max_per_page
  end

  def page
    @page.fetch_positive_number 1
  end

  def per_page
    limited_per_page(@per_page.fetch_positive_number(@default_per_page))
  end

  def to_h
    { page: page, per_page: per_page }
  end

  def empty?
    @page.blank? and @per_page.blank?
  end

  private

  def limited_per_page(value)
    value <= @max_per_page ? value : @max_per_page
  end
end
