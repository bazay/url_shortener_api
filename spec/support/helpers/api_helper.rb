module ApiHelper
  def dispatch(method, path, params = {}, headers = {})
    send method, path, params: params, headers: headers
  end

  def decoded_json_response(text = response.body)
    ActiveSupport::JSON.decode text
  end
end
