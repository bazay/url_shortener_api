RSpec.describe ApplicationApi do
  subject { response }

  before { dispatch method, path }

  describe 'GET /api/version' do
    let(:method) { :get }
    let(:path) { '/api/version' }
    let(:expected_response) { { app_version: app_version, latest_api_version: latest_api_version }.to_json }
    let(:app_version) { 'v1.0.0' }
    let(:latest_api_version) { 'v1.0' }

    its(:body) { is_expected.to eq expected_response }
  end
end
