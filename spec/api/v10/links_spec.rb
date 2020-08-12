RSpec.describe Api::V10::Links do
  subject { decoded_json_response }

  before { dispatch method, path, params }

  describe 'POST /api/v1.0/links' do
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
end
