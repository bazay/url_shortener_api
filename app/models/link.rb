# == Schema Information
#
# Table name: links
#
#  id          :bigint           not null, primary key
#  expires_at  :datetime
#  slug        :string
#  url         :text
#  usage_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_links_on_slug  (slug) UNIQUE
#

class Link < ApplicationRecord
  validates :slug, uniqueness: true, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), presence: true

  SLUG_LENGTH_DEFAULT = 4

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(link_slug_length)
  end

  private

  def link_slug_length
    # Use ENV variable OR default
    Figaro.env.link_slug_length || SLUG_LENGTH_DEFAULT
  end
end
