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

RSpec.describe Link do
  subject(:link) { described_class.new attrs }

  let(:attrs) { {} }

  it { is_expected.not_to be_valid }

  describe 'validations' do
    let(:attrs) { { url: url, slug: slug } }
    let(:url) { 'http://google.com' }
    let(:slug) { '1234' }

    it { is_expected.to be_valid }

    context 'when url is blank' do
      let(:url) { '' }

      it { is_expected.not_to be_valid }
      it { is_expected.to have(2).errors_on(:url) }
    end

    context "when url doesn't start with http" do
      let(:url) { 'google.com' }

      it { is_expected.not_to be_valid }
      it { is_expected.to have(1).errors_on(:url) }
    end

    context 'when url is not unique' do
      before { Link.create(attrs.merge(slug: unique_slug)) }

      let(:unique_slug) { '4321' }

      it { is_expected.to be_valid }
    end

    context 'when slug is nil' do
      let(:slug) { nil }

      it { is_expected.not_to be_valid }
      it { is_expected.to have(1).errors_on(:slug) }
    end

    context 'when slug is not unique' do
      before { Link.create(attrs) }

      it { is_expected.not_to be_valid }
      it { is_expected.to have(1).errors_on(:slug) }
    end
  end
end
