RSpec.describe Api::V10::Links do
  subject(:parsed_body) { decoded_json_response }

  describe 'POST /api/v1.0/links' do
    before { dispatch method, path, params }

    let(:method) { :post }
    let(:path) { '/api/v1.0/links' }
    let(:params) { { link: { url: url } } }
    let(:url) { 'https://google.com' }

    its(['short_url']) { is_expected.to be_present }
    its(['slug']) { is_expected.to be_present }
    its(['url']) { is_expected.to eql url }
    its(['usage_count']) { is_expected.to be_zero }
    its(['expires_at']) { is_expected.to be_nil }
    its(['created_at']) { is_expected.to be_present }

    context 'when URL exists' do
      subject(:request) { dispatch method, path, params }

      it { expect { request }.to change { Link.count }.by(1) }
    end
  end

  describe 'GET /api/v1.0/links/:slug' do
    let(:method) { :get }
    let(:path) { ['/api/v1.0/links', slug].join('/') }
    let(:params) { {} }
    let(:url) { 'http://google.com' }
    let(:slug) { '1234' }

    before do
      Link.create(url: url, slug: '1234')
      dispatch method, path, params
    end

    its(['short_url']) { is_expected.to be_present }
    its(['slug']) { is_expected.to be_present }
    its(['url']) { is_expected.to eql url }
    its(['usage_count']) { is_expected.to be_zero }
    its(['expires_at']) { is_expected.to be_nil }
    its(['created_at']) { is_expected.to be_present }

    context "when slug doesn't match" do
      subject { response }

      let(:slug) { 'not-matching' }

      it { is_expected.to have_http_status :not_found }
    end
  end

  describe 'GET /api/v1.0/links' do
    before { dispatch method, path, params }

    let(:method) { :get }
    let(:path) { '/api/v1.0/links' }
    let(:params) { { page: page, per_page: per_page } }
    let(:page) { nil }
    let(:per_page) { nil }

    it { expect(decoded_json_response).to be_empty }

    context 'when items exist' do
      before do
        @page_links = create_links(5)
        dispatch method, path, params
      end

      let(:actual_page_slugs) { parsed_body.map { |item| item['slug'] } }
      let(:expected_page_slugs) { @page_links.map(&:slug) }

      it { expect(actual_page_slugs).to match_array(expected_page_slugs) }

      context 'when browsing pages' do
        before do
          @page_links = create_links(5)
          dispatch method, path, params
        end

        let(:page) { 2 }
        let(:per_page) { 5 }
        let(:actual_page_slugs) { parsed_body.map { |item| item['slug'] } }
        let(:expected_page_slugs) { @page_links.map(&:slug) }

        it { expect(actual_page_slugs).to match_array expected_page_slugs }
      end
    end

    context 'when specifying above max per page' do
      before do
        create_links(PaginationValues::MAX_PER_PAGE + 1)
        dispatch method, path, params
      end

      let(:page) { 1 }
      let(:per_page) { PaginationValues::MAX_PER_PAGE + 1 }

      it { is_expected.to have(PaginationValues::MAX_PER_PAGE).items }
    end

    context 'when page and per page not specified' do
      before do
        create_links(PaginationValues::DEFAULT_PER_PAGE + 1)
        dispatch method, path, params
      end

      it { is_expected.to have(PaginationValues::DEFAULT_PER_PAGE).items }
    end
  end
end

def create_links(count)
  count.times.map do |i|
    Link.new(url: "http://link#{i + 1}.com").tap do |link|
      link.generate_slug
      link.save
    end
  end
end
