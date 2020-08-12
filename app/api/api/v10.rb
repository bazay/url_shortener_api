module Api
  class V10 < Grape::API
    version 'v1.0'.freeze

    mount V10::Links
  end
end
