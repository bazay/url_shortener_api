class ApplicationApi < Grape::API
  cascade true
  format :json
  default_format :json
  prefix :api

  helpers ::Helpers::ApiResponseHelper
  helpers ::Helpers::VersionHelper

  mount Api::V10

  desc 'Application and API version information'
  get :version do
    { app_version: app_version, latest_api_version: latest_api_version }
  end
end
