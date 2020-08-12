RSpec.describe Api::V10::Links do
  subject { decoded_json_response }

  describe 'POST /api/v1.0/links' do
    before { dispatch method, path, params }

    let(:method) { :post }
    let(:path) { '/api/v1.0/links' }
    let(:params) { { link: { url: url } } }
    let(:url) { 'https://google.com' }

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
end
