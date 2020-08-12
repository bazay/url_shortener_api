RSpec.describe 'Redirects' do
  subject { response }

  describe 'GET /s/:slug' do
    let(:method) { :get }
    let(:path) { "/s/#{slug}" }
    let(:slug) { '1234' }

    before { dispatch method, path }

    it { is_expected.to have_http_status(:not_found) }
    its(:body) { is_expected.to eql "<h1>Not found</h1>\n" }

    context 'when slug exists' do
      before do
        @link = Link.create(url: url, slug: slug)
        dispatch method, path
      end

      let(:url) { 'http://google.com' }

      it { is_expected.to redirect_to url }
      it { expect(@link.reload.usage_count).to eql 1 }
    end
  end
end
